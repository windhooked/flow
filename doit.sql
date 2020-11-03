-- This is only for testing purposes.  In production mode, the
-- consuming application is expected to create the database.
--
-- N.B.  The character set must be specified as 'utf8mb4' for proper
-- UTF-8 handling.  A simple 'utf8' does not suffice.

DROP DATABASE IF EXISTS flow;

--

CREATE DATABASE flow
CHARACTER SET = 'utf8mb4'
COLLATE = 'utf8mb4_unicode_ci';

SET collation_server = 'utf8mb4_unicode_ci';
SET collation_connection = 'utf8mb4_unicode_ci';
DROP TABLE IF EXISTS wf_doctypes_master;

--

CREATE TABLE wf_doctypes_master (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
DROP TABLE IF EXISTS wf_docstates_master;

--

CREATE TABLE wf_docstates_master (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

--

-- This reserved state has ID `1`.  This is used as the only legal
-- state for children documents.
INSERT INTO wf_docstates_master(name)
VALUES('__RESERVED_CHILD_STATE__');
DROP TABLE IF EXISTS wf_docactions_master;

--

CREATE TABLE wf_docactions_master (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    reconfirm TINYINT(1) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
-- This assumes the existence of a master table for users, by name
-- `users_master`.  It also assumes availability of the specified
-- columns in that master table.  This may need to be edited
-- appropriately, depending on your application and database design.

CREATE OR REPLACE VIEW wf_users_master AS
SELECT id, first_name, last_name, email, active
FROM users_master;
DROP TABLE IF EXISTS wf_groups_master;

--

CREATE TABLE wf_groups_master (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    group_type ENUM('G', 'S'),
    PRIMARY KEY (id),
    UNIQUE (name)
);
DROP TABLE IF EXISTS wf_roles_master;

--

CREATE TABLE wf_roles_master (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

--

-- This reserved role is for users who should administer `flow`
-- itself. That includes (but is not limited to) definition and
-- management of document types, their workflows, roles and groups.
INSERT INTO wf_roles_master(name)
VALUES('SUPER_ADMIN');

-- This reserved role is for users who assume apex positions in
-- day-to-day operations.  This role can be used to administer the
-- workflow operations within access contexts, when needed.
INSERT INTO wf_roles_master(name)
VALUES('ADMIN');
DROP TABLE IF EXISTS wf_group_users;

--

CREATE TABLE wf_group_users (
    id INT NOT NULL AUTO_INCREMENT,
    group_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (group_id) REFERENCES wf_groups_master(id),
    UNIQUE (group_id, user_id)
);
DROP TABLE IF EXISTS wf_role_docactions;

--

CREATE TABLE wf_role_docactions (
    id INT NOT NULL AUTO_INCREMENT,
    role_id INT NOT NULL,
    doctype_id INT NOT NULL,
    docaction_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (role_id) REFERENCES wf_roles_master(id),
    FOREIGN KEY (doctype_id) REFERENCES wf_doctypes_master(id),
    FOREIGN KEY (docaction_id) REFERENCES wf_docactions_master(id),
    UNIQUE (role_id, doctype_id, docaction_id)
);
DROP TABLE IF EXISTS wf_access_contexts;

--

CREATE TABLE wf_access_contexts (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    active TINYINT(1) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
DROP TABLE IF EXISTS wf_ac_group_roles;

--

CREATE TABLE wf_ac_group_roles (
    id INT NOT NULL AUTO_INCREMENT,
    ac_id INT NOT NULL,
    group_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ac_id) REFERENCES wf_access_contexts(id),
    FOREIGN KEY (group_id) REFERENCES wf_groups_master(id),
    FOREIGN KEY (role_id) REFERENCES wf_roles_master(id)
);
DROP TABLE IF EXISTS wf_ac_group_hierarchy;

--

CREATE TABLE wf_ac_group_hierarchy (
    id INT NOT NULL AUTO_INCREMENT,
    ac_id INT NOT NULL,
    group_id INT NOT NULL,
    reports_to INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ac_id) REFERENCES wf_access_contexts(id),
    FOREIGN KEY (group_id) REFERENCES wf_groups_master(id),
    FOREIGN KEY (reports_to) REFERENCES wf_groups_master(id),
    UNIQUE (ac_id, group_id)
);
CREATE OR REPLACE VIEW wf_ac_perms_v AS
SELECT ac_grs.ac_id, ac_grs.group_id, gu.user_id, ac_grs.role_id, rdas.doctype_id, rdas.docaction_id
FROM wf_ac_group_roles ac_grs
JOIN wf_group_users gu ON ac_grs.group_id = gu.group_id
JOIN wf_role_docactions rdas ON ac_grs.role_id = rdas.role_id;
-- CREATE TABLE wf_documents_<DOCTYPE_ID> (
--     id INT NOT NULL AUTO_INCREMENT,
--     path VARCHAR(1000) NOT NULL,
--     ac_id INT NOT NULL,
--     docstate_id INT NOT NULL,
--     group_id INT NOT NULL,
--     ctime TIMESTAMP NOT NULL,
--     title VARCHAR(250) NULL,
--     data TEXT NOT NULL,
--     PRIMARY KEY (id),
--     FOREIGN KEY (ac_id) REFERENCES wf_access_contexts(id),
--     FOREIGN KEY (docstate_id) REFERENCES wf_docstates_master(id),
--     FOREIGN KEY (group_id) REFERENCES wf_groups_master(id)
-- );

--

DROP TABLE IF EXISTS wf_document_children;

CREATE TABLE wf_document_children (
    id INT NOT NULL AUTO_INCREMENT,
    parent_doctype_id INT NOT NULL,
    parent_id INT NOT NULL,
    child_doctype_id INT NOT NULL,
    child_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (parent_doctype_id) REFERENCES wf_doctypes_master(id),
    FOREIGN KEY (child_doctype_id) REFERENCES wf_doctypes_master(id),
    UNIQUE (parent_doctype_id, parent_id, child_doctype_id, child_id)
);

--

DROP TABLE IF EXISTS wf_document_blobs;

CREATE TABLE wf_document_blobs (
    id INT NOT NULL AUTO_INCREMENT,
    doctype_id INT NOT NULL,
    doc_id INT NOT NULL,
    sha1sum CHAR(40) NOT NULL,
    name TEXT NOT NULL,
    path TEXT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (doctype_id) REFERENCES wf_doctypes_master(id),
    UNIQUE (doctype_id, doc_id, sha1sum)
);

--

DROP TABLE IF EXISTS wf_document_tags;

CREATE TABLE wf_document_tags (
    id INT NOT NULL AUTO_INCREMENT,
    doctype_id INT NOT NULL,
    doc_id INT NOT NULL,
    tag VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (doctype_id) REFERENCES wf_doctypes_master(id),
    UNIQUE (doctype_id, doc_id, tag)
);
DROP TABLE IF EXISTS wf_docstate_transitions;

--

CREATE TABLE wf_docstate_transitions (
    id INT NOT NULL AUTO_INCREMENT,
    doctype_id INT NOT NULL,
    from_state_id INT NOT NULL,
    docaction_id INT NOT NULL,
    to_state_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (doctype_id) REFERENCES wf_doctypes_master(id),
    FOREIGN KEY (from_state_id) REFERENCES wf_docstates_master(id),
    FOREIGN KEY (docaction_id) REFERENCES wf_docactions_master(id),
    FOREIGN KEY (to_state_id) REFERENCES wf_docstates_master(id),
    UNIQUE (doctype_id, from_state_id, docaction_id, to_state_id)
);
DROP TABLE IF EXISTS wf_docevents;

--

CREATE TABLE wf_docevents (
    id INT NOT NULL AUTO_INCREMENT,
    doctype_id INT NOT NULL,
    doc_id INT NOT NULL,
    docstate_id INT NOT NULL,
    docaction_id INT NOT NULL,
    group_id INT NOT NULL,
    data TEXT,
    ctime TIMESTAMP NOT NULL,
    status ENUM('A', 'P') NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (doctype_id) REFERENCES wf_doctypes_master(id),
    FOREIGN KEY (docstate_id) REFERENCES wf_docstates_master(id),
    FOREIGN KEY (docaction_id) REFERENCES wf_docactions_master(id),
    FOREIGN KEY (group_id) REFERENCES wf_groups_master(id)
);
DROP TABLE IF EXISTS wf_docevent_application;

--

CREATE TABLE wf_docevent_application (
    id INT NOT NULL AUTO_INCREMENT,
    doctype_id INT NOT NULL,
    doc_id INT NOT NULL,
    from_state_id INT NOT NULL,
    docevent_id INT NOT NULL,
    to_state_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (doctype_id) REFERENCES wf_doctypes_master(id),
    FOREIGN KEY (from_state_id) REFERENCES wf_docstates_master(id),
    FOREIGN KEY (docevent_id) REFERENCES wf_docevents(id),
    FOREIGN KEY (to_state_id) REFERENCES wf_docstates_master(id)
);
DROP TABLE IF EXISTS wf_workflows;

--

CREATE TABLE wf_workflows (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    doctype_id INT NOT NULL,
    docstate_id INT NOT NULL,
    active TINYINT(1) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (doctype_id) REFERENCES wf_doctypes_master(id),
    FOREIGN KEY (docstate_id) REFERENCES wf_docstates_master(id),
    UNIQUE (name),
    UNIQUE (doctype_id)
);
DROP TABLE IF EXISTS wf_workflow_nodes;

--

CREATE TABLE wf_workflow_nodes (
    id INT NOT NULL AUTO_INCREMENT,
    doctype_id INT NOT NULL,
    docstate_id INT NOT NULL,
    ac_id INT,
    workflow_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    type ENUM('begin', 'end', 'linear', 'branch', 'joinany', 'joinall') NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (doctype_id) REFERENCES wf_doctypes_master(id),
    FOREIGN KEY (docstate_id) REFERENCES wf_docstates_master(id),
    FOREIGN KEY (ac_id) REFERENCES wf_access_contexts(id),
    FOREIGN KEY (workflow_id) REFERENCES wf_workflows(id),
    UNIQUE (doctype_id, docstate_id),
    UNIQUE (workflow_id, name)
);
DROP TABLE IF EXISTS wf_messages;

--

CREATE TABLE wf_messages (
    id INT NOT NULL AUTO_INCREMENT,
    doctype_id INT NOT NULL,
    doc_id INT NOT NULL,
    docevent_id INT NOT NULL,
    title VARCHAR(250) NOT NULL,
    data TEXT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (doctype_id) REFERENCES wf_doctypes_master(id),
    FOREIGN KEY (docevent_id) REFERENCES wf_docevents(id),
    UNIQUE (doctype_id, doc_id, docevent_id)
);
DROP TABLE IF EXISTS wf_mailboxes;

--

CREATE TABLE wf_mailboxes (
    id INT NOT NULL AUTO_INCREMENT,
    group_id INT NOT NULL,
    message_id INT NOT NULL,
    unread TINYINT(1) NOT NULL,
    ctime TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (group_id) REFERENCES wf_groups_master(id),
    FOREIGN KEY (message_id) REFERENCES wf_messages(id),
    UNIQUE (group_id, message_id)
);
