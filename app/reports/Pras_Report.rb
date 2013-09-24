class PrasReport < Dossier::Report

def sql
    Productserviceline.where(active: true).to_sql
 end

def format_header(column_name)
    custom_headers = {
      margin_percentage: 'Margin %',
      absolute_margin:   'Margin $'
    }
    custom_headers.fetch(column_name.to_sym) { super }
  end

  
end