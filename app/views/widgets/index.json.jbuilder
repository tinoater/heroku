json.array!(@widgets) do |widget|
  json.extract! widget, :id, :name, :description, :stock, :lat, :long
  json.url widget_url(widget, format: :json)
end
