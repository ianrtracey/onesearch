require './services/gdrive'
require './db/database'
require './models/document'
require './models/service'

gdrive = GDrive.new
DataMapper.finalize




def get_doc(file)
	{:name => file.name, :kind => file.kind, :source => "Google Drive",
	:icon => file.icon_link, :url => file.web_view_link}
end


documents = []
iteration = 0




res = gdrive.service.list_files(page_size: 1000, fields: 'nextPageToken, files(id, name, kind, web_view_link, icon_link)')
res.files.each do |f|
	@doc = Document.new
	@doc.attributes = get_doc(f)
	@doc.save
end
# puts "Indexing files from GDrive..."
# while !res.next_page_token.nil?
# 	puts "Indexing page#{iteration}..."
# 	next_page = res.next_page_token
# 	res = gdrive.service.list_files(page_token: next_page, page_size: 1000, fields: 'nextPageToken, files(id, name, kind, web_view_link, icon_link)')
# 	documents << get_docs(res)
# 	iteration += 1
# 	puts documents.count

# end


# documents.each do |doc|
# 	p doc.inspect
# 	@doc = Document.new
# 	@doc.attributes = doc
# 	@doc.save
# end

