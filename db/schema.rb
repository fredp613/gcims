# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140702213208) do


  create_extension "pg_trgm", :version => "1.0"
  create_extension "fuzzystrmatch", :version => "1.0"

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"

  create_table "addresstypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "applicationcustomtemplates", force: true do |t|
    t.integer  "user_id"
    t.integer  "application_id"
    t.integer  "customtemplate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applicationcustomtemplates", ["application_id"], :name => "index_applicationcustomtemplates_on_application_id"
  add_index "applicationcustomtemplates", ["customtemplate_id"], :name => "index_applicationcustomtemplates_on_customtemplate_id"
  add_index "applicationcustomtemplates", ["user_id"], :name => "index_applicationcustomtemplates_on_user_id"

  create_table "applications", force: true do |t|
    t.integer  "commitmentitem_id"
    t.integer  "project_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "summarycommitment_id"
    t.integer  "subserviceline_id"
    t.integer  "productserviceline_id"
    t.integer  "applicationtype_id"
    t.string   "corporate_file_number"
    t.decimal  "requested"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "decision_by"
    t.integer  "responsible_official"
    t.integer  "requested_other"
    t.datetime "startdate"
    t.datetime "enddate"
  end

  create_table "applicationtypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bands", force: true do |t|
    t.string   "bandnumber"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budgetcategories", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budgetitems", force: true do |t|
    t.string   "title"
    t.text     "desc"
    t.decimal  "forecast"
    t.decimal  "actual"
    t.integer  "application_id"
    t.integer  "budgetcategory_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "funding_source"
    t.string   "fiscalyear_id"
  end

  create_table "cfcts", force: true do |t|
    t.integer  "customfield_id"
    t.integer  "customtemplate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cfcts", ["customfield_id"], :name => "index_cfcts_on_customfield_id"
  add_index "cfcts", ["customtemplate_id"], :name => "index_cfcts_on_customtemplate_id"

  create_table "charities", force: true do |t|
    t.string   "registrationnumber"
    t.datetime "registrationdate"
    t.integer  "client_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "cicts", force: true do |t|
    t.integer  "commitmentitem_id"
    t.integer  "customtemplate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cicts", ["commitmentitem_id"], :name => "index_cicts_on_commitmentitem_id"
  add_index "cicts", ["customtemplate_id"], :name => "index_cicts_on_customtemplate_id"

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "clienttype_id"
    t.string   "name1"
    t.string   "salutation"
    t.boolean  "incorporated"
    t.boolean  "registeredband"
    t.boolean  "registeredcharity"
    t.text     "mandate"
    t.string   "token"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "clients_locations", force: true do |t|
    t.integer  "location_id"
    t.integer  "client_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "addresstype_id"
  end

  create_table "clienttypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commitmentitems", force: true do |t|
    t.string   "ci_name"
    t.boolean  "active"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id"
    t.integer  "summarycommitment_id"
    t.datetime "startdate"
    t.datetime "enddate"
  end

  add_index "commitmentitems", ["id"], :name => "index_commitmentitems_on_id"
  add_index "commitmentitems", ["summarycommitment_id"], :name => "index_commitmentitems_on_summarycommitment_id"
  add_index "commitmentitems", ["user_id"], :name => "index_commitmentitems_on_user_id"

  create_table "contacts", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "client_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "authority"
    t.integer  "contacttype_id"
    t.string   "title"
    t.string   "salutation"
    t.integer  "user_id"
  end

  create_table "contacts_locations", force: true do |t|
    t.integer  "location_id"
    t.integer  "contact_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "addresstype_id"
  end

  create_table "contacttypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "corporations", force: true do |t|
    t.string   "level"
    t.string   "businessnumber"
    t.integer  "client_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "countries", force: true do |t|
    t.string  "iso"
    t.string  "name"
    t.integer "rank"
  end

  create_table "customfieldconditions", force: true do |t|
    t.integer  "customfieldvalidator_id"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customfieldconditions", ["customfieldvalidator_id"], :name => "index_customfieldconditions_on_customfieldvalidator_id"

  create_table "customfields", force: true do |t|
    t.string   "field_type"
    t.string   "field_name"
    t.string   "field_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "field_label"
    t.boolean  "required"
  end

  create_table "customfieldvalidators", force: true do |t|
    t.integer  "customfield_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customfieldvalidators", ["customfield_id"], :name => "index_customfieldvalidators_on_customfield_id"

  create_table "customfieldvalues", force: true do |t|
    t.string   "value"
    t.integer  "user_id"
    t.integer  "wizardcustomtemplate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customfield_id"
    t.integer  "application_id"
    t.integer  "applicationcustomtemplate_id"
  end

  add_index "customfieldvalues", ["user_id"], :name => "index_customfieldvalues_on_user_id"
  add_index "customfieldvalues", ["wizardcustomtemplate_id"], :name => "index_customfieldvalues_on_wizardcustomtemplate_id"

  create_table "customtemplates", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "customtemplatetype_id"
  end

  create_table "customtemplatetypes", force: true do |t|
    t.string   "ct_type"
    t.integer  "modelstate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customtemplatetypes", ["modelstate_id"], :name => "index_customtemplatetypes_on_modelstate_id"

  create_table "divisions", force: true do |t|
    t.string   "name"
    t.string   "name1"
    t.string   "name2"
    t.integer  "client_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "state"
  end

  create_table "emails", force: true do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client_id"
    t.integer  "contact_id"
    t.string   "type"
  end

  create_table "fincodes", force: true do |t|
    t.integer  "productserviceline_id"
    t.integer  "subserviceline_id"
    t.integer  "summarycommitment_id"
    t.integer  "commitmentitem_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "fiscalyears", force: true do |t|
    t.string   "fy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "startdate"
    t.datetime "enddate"
  end

  create_table "locations", force: true do |t|
    t.string   "addressline1"
    t.string   "addressline2"
    t.string   "addressline3"
    t.string   "addressline4"
    t.string   "city"
    t.integer  "state_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "country_id"
    t.string   "postal"
  end

  add_index "locations", ["country_id"], :name => "index_locations_on_country_id"

  create_table "modelstates", force: true do |t|
    t.integer  "user_id"
    t.string   "state"
    t.string   "object"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "modelstates", ["user_id"], :name => "index_modelstates_on_user_id"

  create_table "otherfunders", force: true do |t|
    t.string   "name"
    t.integer  "requested"
    t.integer  "application_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "phones", force: true do |t|
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client_id"
    t.integer  "contact_id"
    t.string   "type"
  end

  create_table "productserviceline_fiscalyears", force: true do |t|
    t.integer  "productserviceline_id"
    t.integer  "fiscalyear_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "productservicelines", force: true do |t|
    t.string   "psl_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "startdate"
    t.datetime "enddate"
  end

  add_index "productservicelines", ["id"], :name => "index_productservicelines_on_id"
  add_index "productservicelines", ["user_id"], :name => "index_productservicelines_on_user_id"

  create_table "programbudgets", force: true do |t|
    t.string   "fiscalyear"
    t.decimal  "amount"
    t.integer  "user_id"
    t.integer  "commitmentitem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projectcontacts", force: true do |t|
    t.integer  "contacttype_id"
    t.integer  "contact_id"
    t.integer  "project_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "authority"
  end

  create_table "projects", force: true do |t|
    t.string   "projectname"
    t.text     "projectdesc"
    t.integer  "client_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "startdate"
    t.datetime "enddate"
    t.string   "token"
    t.string   "state"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "division_id"
  end

  create_table "roles", force: true do |t|
    t.string   "role"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string  "name"
    t.integer "country_id"
    t.string  "iso"
  end

  create_table "subservicelines", force: true do |t|
    t.string   "ssl_name"
    t.boolean  "active"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "user_id"
    t.integer  "productserviceline_id"
    t.datetime "startdate"
    t.datetime "enddate"
  end

  add_index "subservicelines", ["id"], :name => "index_subservicelines_on_id"
  add_index "subservicelines", ["productserviceline_id"], :name => "index_subservicelines_on_productserviceline_id"
  add_index "subservicelines", ["user_id"], :name => "index_subservicelines_on_user_id"

  create_table "summarycommitments", force: true do |t|
    t.string   "sc_name"
    t.boolean  "active"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
    t.integer  "subserviceline_id"
    t.datetime "startdate"
    t.datetime "enddate"
  end

  add_index "summarycommitments", ["id"], :name => "index_summarycommitments_on_id"
  add_index "summarycommitments", ["subserviceline_id"], :name => "index_summarycommitments_on_subserviceline_id"
  add_index "summarycommitments", ["user_id"], :name => "index_summarycommitments_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.integer  "role_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "websites", force: true do |t|
    t.string   "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client_id"
  end

  create_table "wizardcustomtemplates", force: true do |t|
    t.integer  "user_id"
    t.integer  "customtemplate_id"
    t.integer  "wizard_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wizardcustomtemplates", ["customtemplate_id"], :name => "index_wizardcustomtemplates_on_customtemplate_id"
  add_index "wizardcustomtemplates", ["user_id"], :name => "index_wizardcustomtemplates_on_user_id"
  add_index "wizardcustomtemplates", ["wizard_id"], :name => "index_wizardcustomtemplates_on_wizard_id"

  create_table "wizards", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "modelstate_id"
    t.integer  "commitmentitem_id"
  end

  add_index "wizards", ["user_id"], :name => "index_wizards_on_user_id"


end
