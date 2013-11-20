--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresstypes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE addresstypes (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: addresstypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE addresstypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresstypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE addresstypes_id_seq OWNED BY addresstypes.id;


--
-- Name: applications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE applications (
    id integer NOT NULL,
    commitmentitem_id integer,
    project_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    summarycommitment_id integer,
    subserviceline_id integer,
    productserviceline_id integer,
    applicationtype_id integer,
    corporate_file_number character varying(255),
    requested numeric,
    created_by integer,
    updated_by integer,
    decision_by integer,
    responsible_official integer
);


--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE applications_id_seq OWNED BY applications.id;


--
-- Name: applicationtypes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE applicationtypes (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: applicationtypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE applicationtypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: applicationtypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE applicationtypes_id_seq OWNED BY applicationtypes.id;


--
-- Name: bands; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bands (
    id integer NOT NULL,
    bandnumber character varying(255),
    client_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bands_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bands_id_seq OWNED BY bands.id;


--
-- Name: budgetcategories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE budgetcategories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: budgetcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE budgetcategories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: budgetcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE budgetcategories_id_seq OWNED BY budgetcategories.id;


--
-- Name: budgetitems; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE budgetitems (
    id integer NOT NULL,
    title character varying(255),
    "desc" text,
    forecast numeric,
    actual numeric,
    fiscalyear_id integer,
    application_id integer,
    budgetcategory_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    funding_source character varying(255)
);


--
-- Name: budgetitems_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE budgetitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: budgetitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE budgetitems_id_seq OWNED BY budgetitems.id;


--
-- Name: charities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE charities (
    id integer NOT NULL,
    registrationnumber character varying(255),
    registrationdate timestamp without time zone,
    client_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: charities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE charities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: charities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE charities_id_seq OWNED BY charities.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    clienttype_id integer,
    name1 character varying(255),
    salutation character varying(255),
    incorporated boolean,
    registeredband boolean,
    registeredcharity boolean,
    mandate text,
    token character varying(255),
    created_by integer,
    updated_by integer
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: clients_locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE clients_locations (
    id integer NOT NULL,
    location_id integer,
    client_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    addresstype_id integer
);


--
-- Name: clients_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clients_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clients_locations_id_seq OWNED BY clients_locations.id;


--
-- Name: clienttypes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE clienttypes (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: clienttypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clienttypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clienttypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clienttypes_id_seq OWNED BY clienttypes.id;


--
-- Name: commitmentitems; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE commitmentitems (
    id integer NOT NULL,
    ci_name character varying(255),
    active boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    summarycommitment_id integer
);


--
-- Name: commitmentitems_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE commitmentitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commitmentitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE commitmentitems_id_seq OWNED BY commitmentitems.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    client_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    authority boolean,
    contacttype_id integer,
    title character varying(255),
    salutation character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: contacts_locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contacts_locations (
    id integer NOT NULL,
    location_id integer,
    contact_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    addresstype_id integer
);


--
-- Name: contacts_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contacts_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contacts_locations_id_seq OWNED BY contacts_locations.id;


--
-- Name: contacttypes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contacttypes (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: contacttypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contacttypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacttypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contacttypes_id_seq OWNED BY contacttypes.id;


--
-- Name: corporations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE corporations (
    id integer NOT NULL,
    level character varying(255),
    businessnumber character varying(255),
    client_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: corporations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE corporations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: corporations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE corporations_id_seq OWNED BY corporations.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE countries (
    id integer NOT NULL,
    iso character varying(255),
    name character varying(255),
    rank integer
);


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE countries_id_seq OWNED BY countries.id;


--
-- Name: divisions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE divisions (
    id integer NOT NULL,
    name character varying(255),
    name1 character varying(255),
    name2 character varying(255),
    client_id integer,
    location_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255)
);


--
-- Name: divisions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE divisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: divisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE divisions_id_seq OWNED BY divisions.id;


--
-- Name: emails; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE emails (
    id integer NOT NULL,
    email character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    client_id integer,
    contact_id integer,
    type character varying(255)
);


--
-- Name: emails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE emails_id_seq OWNED BY emails.id;


--
-- Name: fincodes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fincodes (
    id integer NOT NULL,
    productserviceline_id integer,
    subserviceline_id integer,
    summarycommitment_id integer,
    commitmentitem_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fincodes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fincodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fincodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fincodes_id_seq OWNED BY fincodes.id;


--
-- Name: fiscalyears; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fiscalyears (
    id integer NOT NULL,
    fy character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    startdate timestamp without time zone,
    enddate timestamp without time zone
);


--
-- Name: fiscalyears_commitmentitems; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fiscalyears_commitmentitems (
    fiscalyear_id integer,
    commitmentitem_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fiscalyears_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fiscalyears_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fiscalyears_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fiscalyears_id_seq OWNED BY fiscalyears.id;


--
-- Name: fiscalyears_productservicelines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fiscalyears_productservicelines (
    fiscalyear_id integer,
    productserviceline_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fiscalyears_subservicelines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fiscalyears_subservicelines (
    fiscalyear_id integer,
    subserviceline_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fiscalyears_summarycommitments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fiscalyears_summarycommitments (
    fiscalyear_id integer,
    summarycommitment_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    addressline1 character varying(255),
    addressline2 character varying(255),
    addressline3 character varying(255),
    addressline4 character varying(255),
    city character varying(255),
    state_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    country_id integer,
    postal character varying(255)
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pg_search_documents (
    id integer NOT NULL,
    content text,
    searchable_id integer,
    searchable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pg_search_documents_id_seq OWNED BY pg_search_documents.id;


--
-- Name: phones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE phones (
    id integer NOT NULL,
    phone character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    client_id integer,
    contact_id integer,
    type character varying(255)
);


--
-- Name: phones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE phones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE phones_id_seq OWNED BY phones.id;


--
-- Name: productserviceline_fiscalyears; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE productserviceline_fiscalyears (
    id integer NOT NULL,
    productserviceline_id integer,
    fiscalyear_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: productserviceline_fiscalyears_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE productserviceline_fiscalyears_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: productserviceline_fiscalyears_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE productserviceline_fiscalyears_id_seq OWNED BY productserviceline_fiscalyears.id;


--
-- Name: productservicelines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE productservicelines (
    id integer NOT NULL,
    psl_name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    active boolean
);


--
-- Name: productservicelines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE productservicelines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: productservicelines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE productservicelines_id_seq OWNED BY productservicelines.id;


--
-- Name: projectcontacts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projectcontacts (
    id integer NOT NULL,
    contacttype_id integer,
    contact_id integer,
    project_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    authority boolean
);


--
-- Name: projectcontacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projectcontacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projectcontacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projectcontacts_id_seq OWNED BY projectcontacts.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    projectname character varying(255),
    projectdesc text,
    client_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    token character varying(255),
    state character varying(255),
    created_by integer,
    updated_by integer,
    division_id integer
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: states; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE states (
    id integer NOT NULL,
    name character varying(255),
    country_id integer,
    iso character varying(255)
);


--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE states_id_seq OWNED BY states.id;


--
-- Name: subservicelines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE subservicelines (
    id integer NOT NULL,
    ssl_name character varying(255),
    active boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    productserviceline_id integer
);


--
-- Name: subservicelines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE subservicelines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subservicelines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE subservicelines_id_seq OWNED BY subservicelines.id;


--
-- Name: summarycommitments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE summarycommitments (
    id integer NOT NULL,
    sc_name character varying(255),
    active boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    subserviceline_id integer
);


--
-- Name: summarycommitments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE summarycommitments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: summarycommitments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE summarycommitments_id_seq OWNED BY summarycommitments.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: websites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE websites (
    id integer NOT NULL,
    website character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    client_id integer
);


--
-- Name: websites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE websites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: websites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE websites_id_seq OWNED BY websites.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresstypes ALTER COLUMN id SET DEFAULT nextval('addresstypes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY applications ALTER COLUMN id SET DEFAULT nextval('applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY applicationtypes ALTER COLUMN id SET DEFAULT nextval('applicationtypes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bands ALTER COLUMN id SET DEFAULT nextval('bands_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY budgetcategories ALTER COLUMN id SET DEFAULT nextval('budgetcategories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY budgetitems ALTER COLUMN id SET DEFAULT nextval('budgetitems_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY charities ALTER COLUMN id SET DEFAULT nextval('charities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients_locations ALTER COLUMN id SET DEFAULT nextval('clients_locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clienttypes ALTER COLUMN id SET DEFAULT nextval('clienttypes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY commitmentitems ALTER COLUMN id SET DEFAULT nextval('commitmentitems_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contacts_locations ALTER COLUMN id SET DEFAULT nextval('contacts_locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contacttypes ALTER COLUMN id SET DEFAULT nextval('contacttypes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY corporations ALTER COLUMN id SET DEFAULT nextval('corporations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY countries ALTER COLUMN id SET DEFAULT nextval('countries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY divisions ALTER COLUMN id SET DEFAULT nextval('divisions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY emails ALTER COLUMN id SET DEFAULT nextval('emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fincodes ALTER COLUMN id SET DEFAULT nextval('fincodes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiscalyears ALTER COLUMN id SET DEFAULT nextval('fiscalyears_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pg_search_documents ALTER COLUMN id SET DEFAULT nextval('pg_search_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY phones ALTER COLUMN id SET DEFAULT nextval('phones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY productserviceline_fiscalyears ALTER COLUMN id SET DEFAULT nextval('productserviceline_fiscalyears_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY productservicelines ALTER COLUMN id SET DEFAULT nextval('productservicelines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projectcontacts ALTER COLUMN id SET DEFAULT nextval('projectcontacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY states ALTER COLUMN id SET DEFAULT nextval('states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY subservicelines ALTER COLUMN id SET DEFAULT nextval('subservicelines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY summarycommitments ALTER COLUMN id SET DEFAULT nextval('summarycommitments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY websites ALTER COLUMN id SET DEFAULT nextval('websites_id_seq'::regclass);


--
-- Name: addresstypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY addresstypes
    ADD CONSTRAINT addresstypes_pkey PRIMARY KEY (id);


--
-- Name: applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: applicationtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY applicationtypes
    ADD CONSTRAINT applicationtypes_pkey PRIMARY KEY (id);


--
-- Name: bands_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bands
    ADD CONSTRAINT bands_pkey PRIMARY KEY (id);


--
-- Name: budgetcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY budgetcategories
    ADD CONSTRAINT budgetcategories_pkey PRIMARY KEY (id);


--
-- Name: budgetitems_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY budgetitems
    ADD CONSTRAINT budgetitems_pkey PRIMARY KEY (id);


--
-- Name: charities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY charities
    ADD CONSTRAINT charities_pkey PRIMARY KEY (id);


--
-- Name: clients_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients_locations
    ADD CONSTRAINT clients_locations_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: clienttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clienttypes
    ADD CONSTRAINT clienttypes_pkey PRIMARY KEY (id);


--
-- Name: commitmentitems_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY commitmentitems
    ADD CONSTRAINT commitmentitems_pkey PRIMARY KEY (id);


--
-- Name: contacts_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts_locations
    ADD CONSTRAINT contacts_locations_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: contacttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacttypes
    ADD CONSTRAINT contacttypes_pkey PRIMARY KEY (id);


--
-- Name: corporations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY corporations
    ADD CONSTRAINT corporations_pkey PRIMARY KEY (id);


--
-- Name: countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY divisions
    ADD CONSTRAINT divisions_pkey PRIMARY KEY (id);


--
-- Name: emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: fincodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fincodes
    ADD CONSTRAINT fincodes_pkey PRIMARY KEY (id);


--
-- Name: fiscalyears_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fiscalyears
    ADD CONSTRAINT fiscalyears_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: phones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (id);


--
-- Name: productserviceline_fiscalyears_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY productserviceline_fiscalyears
    ADD CONSTRAINT productserviceline_fiscalyears_pkey PRIMARY KEY (id);


--
-- Name: productservicelines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY productservicelines
    ADD CONSTRAINT productservicelines_pkey PRIMARY KEY (id);


--
-- Name: projectcontacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projectcontacts
    ADD CONSTRAINT projectcontacts_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: states_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: subservicelines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY subservicelines
    ADD CONSTRAINT subservicelines_pkey PRIMARY KEY (id);


--
-- Name: summarycommitments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY summarycommitments
    ADD CONSTRAINT summarycommitments_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: websites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY websites
    ADD CONSTRAINT websites_pkey PRIMARY KEY (id);


--
-- Name: index_commitmentitems_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_commitmentitems_on_id ON commitmentitems USING btree (id);


--
-- Name: index_commitmentitems_on_summarycommitment_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_commitmentitems_on_summarycommitment_id ON commitmentitems USING btree (summarycommitment_id);


--
-- Name: index_commitmentitems_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_commitmentitems_on_user_id ON commitmentitems USING btree (user_id);


--
-- Name: index_locations_on_country_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_locations_on_country_id ON locations USING btree (country_id);


--
-- Name: index_productservicelines_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_productservicelines_on_id ON productservicelines USING btree (id);


--
-- Name: index_productservicelines_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_productservicelines_on_user_id ON productservicelines USING btree (user_id);


--
-- Name: index_subservicelines_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_subservicelines_on_id ON subservicelines USING btree (id);


--
-- Name: index_subservicelines_on_productserviceline_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_subservicelines_on_productserviceline_id ON subservicelines USING btree (productserviceline_id);


--
-- Name: index_subservicelines_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_subservicelines_on_user_id ON subservicelines USING btree (user_id);


--
-- Name: index_summarycommitments_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_summarycommitments_on_id ON summarycommitments USING btree (id);


--
-- Name: index_summarycommitments_on_subserviceline_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_summarycommitments_on_subserviceline_id ON summarycommitments USING btree (subserviceline_id);


--
-- Name: index_summarycommitments_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_summarycommitments_on_user_id ON summarycommitments USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130704154514');

INSERT INTO schema_migrations (version) VALUES ('20130704154715');

INSERT INTO schema_migrations (version) VALUES ('20130704154800');

INSERT INTO schema_migrations (version) VALUES ('20130704154945');

INSERT INTO schema_migrations (version) VALUES ('20130704155411');

INSERT INTO schema_migrations (version) VALUES ('20130708000652');

INSERT INTO schema_migrations (version) VALUES ('20130708002124');

INSERT INTO schema_migrations (version) VALUES ('20130708002352');

INSERT INTO schema_migrations (version) VALUES ('20130708003730');

INSERT INTO schema_migrations (version) VALUES ('20130708004100');

INSERT INTO schema_migrations (version) VALUES ('20130712025831');

INSERT INTO schema_migrations (version) VALUES ('20130712034545');

INSERT INTO schema_migrations (version) VALUES ('20130714041409');

INSERT INTO schema_migrations (version) VALUES ('20130715015559');

INSERT INTO schema_migrations (version) VALUES ('20130715024051');

INSERT INTO schema_migrations (version) VALUES ('20130715031120');

INSERT INTO schema_migrations (version) VALUES ('20130715033507');

INSERT INTO schema_migrations (version) VALUES ('20130718221156');

INSERT INTO schema_migrations (version) VALUES ('20130718223826');

INSERT INTO schema_migrations (version) VALUES ('20130719213803');

INSERT INTO schema_migrations (version) VALUES ('20130719214347');

INSERT INTO schema_migrations (version) VALUES ('20130720024126');

INSERT INTO schema_migrations (version) VALUES ('20130804033147');

INSERT INTO schema_migrations (version) VALUES ('20130804034023');

INSERT INTO schema_migrations (version) VALUES ('20130804150815');

INSERT INTO schema_migrations (version) VALUES ('20130804151036');

INSERT INTO schema_migrations (version) VALUES ('20130804151104');

INSERT INTO schema_migrations (version) VALUES ('20130804151312');

INSERT INTO schema_migrations (version) VALUES ('20130804155228');

INSERT INTO schema_migrations (version) VALUES ('20130804163756');

INSERT INTO schema_migrations (version) VALUES ('20130807011731');

INSERT INTO schema_migrations (version) VALUES ('20130807011746');

INSERT INTO schema_migrations (version) VALUES ('20130807011854');

INSERT INTO schema_migrations (version) VALUES ('20130807011904');

INSERT INTO schema_migrations (version) VALUES ('20130807011954');

INSERT INTO schema_migrations (version) VALUES ('20130808012331');

INSERT INTO schema_migrations (version) VALUES ('20130808175226');

INSERT INTO schema_migrations (version) VALUES ('20130809014628');

INSERT INTO schema_migrations (version) VALUES ('20130809015830');

INSERT INTO schema_migrations (version) VALUES ('20130816214916');

INSERT INTO schema_migrations (version) VALUES ('20130821162607');

INSERT INTO schema_migrations (version) VALUES ('20130821164218');

INSERT INTO schema_migrations (version) VALUES ('20130821170718');

INSERT INTO schema_migrations (version) VALUES ('20130821172550');

INSERT INTO schema_migrations (version) VALUES ('20130821172930');

INSERT INTO schema_migrations (version) VALUES ('20130822021235');

INSERT INTO schema_migrations (version) VALUES ('20130827012244');

INSERT INTO schema_migrations (version) VALUES ('20130827012300');

INSERT INTO schema_migrations (version) VALUES ('20130827012329');

INSERT INTO schema_migrations (version) VALUES ('20130827013255');

INSERT INTO schema_migrations (version) VALUES ('20130827181522');

INSERT INTO schema_migrations (version) VALUES ('20130827181756');

INSERT INTO schema_migrations (version) VALUES ('20130827192831');

INSERT INTO schema_migrations (version) VALUES ('20130827200242');

INSERT INTO schema_migrations (version) VALUES ('20130827200816');

INSERT INTO schema_migrations (version) VALUES ('20130827202400');

INSERT INTO schema_migrations (version) VALUES ('20130827202441');

INSERT INTO schema_migrations (version) VALUES ('20130827202620');

INSERT INTO schema_migrations (version) VALUES ('20130901013226');

INSERT INTO schema_migrations (version) VALUES ('20130901224755');

INSERT INTO schema_migrations (version) VALUES ('20130901225025');

INSERT INTO schema_migrations (version) VALUES ('20130901225314');

INSERT INTO schema_migrations (version) VALUES ('20130903202713');

INSERT INTO schema_migrations (version) VALUES ('20130906010706');

INSERT INTO schema_migrations (version) VALUES ('20130906010800');

INSERT INTO schema_migrations (version) VALUES ('20130906144019');

INSERT INTO schema_migrations (version) VALUES ('20130906144142');

INSERT INTO schema_migrations (version) VALUES ('20130906145143');

INSERT INTO schema_migrations (version) VALUES ('20130906145300');

INSERT INTO schema_migrations (version) VALUES ('20130906145924');

INSERT INTO schema_migrations (version) VALUES ('20130906145943');

INSERT INTO schema_migrations (version) VALUES ('20130906154242');

INSERT INTO schema_migrations (version) VALUES ('20130906171955');

INSERT INTO schema_migrations (version) VALUES ('20130907181807');

INSERT INTO schema_migrations (version) VALUES ('20130914004400');

INSERT INTO schema_migrations (version) VALUES ('20130920193343');

INSERT INTO schema_migrations (version) VALUES ('20130920225717');

INSERT INTO schema_migrations (version) VALUES ('20130921194217');

INSERT INTO schema_migrations (version) VALUES ('20130921211238');

INSERT INTO schema_migrations (version) VALUES ('20130929190422');

INSERT INTO schema_migrations (version) VALUES ('20130929191931');

INSERT INTO schema_migrations (version) VALUES ('20130929192036');

INSERT INTO schema_migrations (version) VALUES ('20130929192843');

INSERT INTO schema_migrations (version) VALUES ('20130929192902');

INSERT INTO schema_migrations (version) VALUES ('20131002010216');

INSERT INTO schema_migrations (version) VALUES ('20131011195405');

INSERT INTO schema_migrations (version) VALUES ('20131011202216');

INSERT INTO schema_migrations (version) VALUES ('20131026210100');

INSERT INTO schema_migrations (version) VALUES ('20131102202641');

INSERT INTO schema_migrations (version) VALUES ('20131114033903');

INSERT INTO schema_migrations (version) VALUES ('20131115233929');

INSERT INTO schema_migrations (version) VALUES ('20131118214242');