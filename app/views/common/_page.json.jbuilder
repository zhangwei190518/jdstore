json.page_info do
  current_page = resources.current_page

  json.current_page current_page
  json.total_pages resources.total_pages
  json.per_page resources.per_page
  json.total_entries resources.total_entries
  json.next_page current_page == resources.total_pages ? nil : (current_page + 1)
  json.previous_page current_page == 1 ? nil : (current_page - 1)
end