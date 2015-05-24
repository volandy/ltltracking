require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'cgi'
require 'openssl'

set :port, 8080
set :static, true
set :public_folder, "public"
set :views, "views"

get '/' do
    erb :index
end

get '/pittohio/' do
	erb :pitd_pro
	
    
end

post '/pittohio/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://works.pittohio.com/mypittohio/OnlineTools/OT_ShipmentTrace_Details.asp?sessionid=464A7459-0B07-4566-9C43-D70EF7688D96&menuid=&pro=#{escaped_pro}&bol=&PP=0"
	data = Nokogiri::HTML(open(url))
	@stat = data.css(".left+ .right b").text
	@eta = data.css("tr:nth-child(4) .right").text
	@title = data.css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/I3TdEHj.jpg"
	erb :status

end

get '/daytonfreight/' do
	erb :dafg_pro
	
    
end

post '/daytonfreight/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://daytonfreight.com/Tracking/TrackingDetail.aspx?proNum=#{escaped_pro}"
	data = Nokogiri::HTML(open(url))
	@stat = data.xpath("//td[@id='tcLastActivity']").text
	@eta = data.xpath("//*[(@id = 'tcEta')]").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/nORci7Z.jpg"

	erb :status
end

get '/newengland/' do
	erb :nemf_pro
	
    
end

post '/newengland/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://nemfweb.nemf.com/shptrack.nsf/request?openagent=1&pro=#{escaped_pro}&submit=Track"
	data = Nokogiri::HTML(open(url))
	@stat = data.css("td:nth-child(1)").text
	@eta = data.css("td:nth-child(2)").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/jw2oq0W.jpg"

	erb :status
end

get '/olddominion/' do
	erb :odfl_pro
	
    
end

post '/olddominion/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://www.odfl.com/Trace/standardResult.faces?pro=#{escaped_pro}"
	data = Nokogiri::HTML(open(url))
	@stat = data.xpath("//*[(@id = 'traceResult\:j_idt61')]").text
	@eta =  data.xpath("//*[(@id = 'traceResult\:j_idt53')]").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/0ClJy39.jpg"

	erb :status
end

get '/centraltransport/' do
	erb :ctii_pro
	
    
end

post '/centraltransport/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://www.centraltransport.com/Confirm/trace.aspx?pro=#{escaped_pro}"
	data = Nokogiri::HTML(open(url))
	@stat = data.css(".hh~ .hh+ .hh").text
	@eta = data.css(".dates~ .dates+ .dates").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/o0hVsCV.jpg"

	erb :status
end

get '/aduiepyle/' do
	erb :pyle_pro
	
    
end

post '/aduiepyle/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://aduiepyle.com/LTL/ShipmentTracking?Pro=#{escaped_pro}"
	data = Nokogiri::HTML(open(url))
	@stat = data.xpath('//*[(@id = "MainContent_Repeater1_lblStatus_0")]').text
	@eta = data.xpath('//*[(@id = "MainContent_Repeater1_lblDelivered_0")]').text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/Qz29rAz.jpg"

	erb :status
end

get '/southeastfreightlines/' do
	erb :sefl_pro
	
    
end

post '/southeastfreightlines/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "https://sefl.com/seflWebsite/servlet?Type=PN&login=null&ZipCode=00000&IntranetAcctCallId=&seflMenuUsername=&GUID=&seflMenuEmployeeLocation=&action=Tracing_Trace_by_pro&externalMenu=true&wantsToBeSecure=Y&EMP_GUID=null&RefNum=#{escaped_pro}&seflMenuEmployeeID=&Protocol_Changed=true"
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
	data = Nokogiri::HTML(open(url))
	@eta = data.xpath("//*[@id='resultsTable']/tbody/tr[12]/td[4]/text()[1]").text
	@stat = data.xpath("//*[@id='resultsTable']/tbody/tr[16]/td[4]").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/WPncEiH.jpg"

	erb :status
end

get '/centralfreight/' do
	erb :cenf_pro
	
    
end

post '/centralfreight/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://centralfreight.com/website/mf/mfInquiry.aspx?inqmode=PRO&pro=#{escaped_pro}"
	data = Nokogiri::HTML(open(url))
	@stat = data.xpath("//*[@id='main']/div[16]/text()").text 
	@eta = data.xpath("//*[@id='main']/table[4]/tbody/tr[3]/td[2]").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
    @img = "http://i.imgur.com/WszODs8.jpg"

	erb :status
end



get '/abfs/' do
	erb :abfs_pro
	
    
end

post '/abfs/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "https://www.abfs.com/tools/trace/default.asp?hidSubmitted=Y&refno0=#{escaped_pro}&reftype0=A"
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
	data = Nokogiri::HTML(open(url))
	@eta = data.css("td+ td .dataTxt").text
	@stat = data.css("#PageResults .formTxt").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/tvyA4rx.jpg"

	erb :status
end

get '/roadrunner/' do
	erb :rdfs_pro
	
    
end



post '/roadrunner/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "https://www.rrts.com/Tools/Tracking/Pages/MultipleResults.aspx?PROS=#{escaped_pro}"
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
	data = Nokogiri::HTML(open(url))
	@eta = data.xpath("//*[(@id = 'ctl00_ctl50_g_a00bf657_07a9_444e_9b38_fb00487e0952_TraceResultID308472794_lblProjectedDeliveryDate')]").text
	@stat= data.xpath("//*[(@id = 'ctl00_ctl50_g_a00bf657_07a9_444e_9b38_fb00487e0952_TraceResultID343057055_lblDeliveredDate')]").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/OoYAimI.jpg"

	erb :status
end

get '/aaacooper/' do
	erb :aact_pro
	
    
end

post '/aaacooper/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://www.aaacooper.com/Transit/ProTrackResults.aspx?ProNum=#{escaped_pro}&AllAccounts=true"
    data = Nokogiri::HTML(open(url))
	@eta = data.css("#AAACooperMasterPage_bodyContent_lblDeliveryDate").text
	@stat = data.css("#AAACooperMasterPage_bodyContent_lblDeliveryStatus").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/NRKF219.jpg"

	erb :status
end




get '/dohrn/' do
	erb :dohrn_pro
	
    
end

post '/dohrn/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://www.dohrn.com/scripts/cgiip.exe/boldetail.htm?wbtn=PRO&wpro1=#{escaped_pro}&seskey=&nav=&language="
    data = Nokogiri::HTML(open(url))
	@eta = data.xpath("//*[@id='hist.0x000000001594b9ee']/table/tbody/tr[1]/td[3]").text
	@stat = data.xpath("//*[@id='hist.0x000000001594b9ee']/table/tbody/tr[1]/td[1]").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/M4vB4fy.jpg"

	erb :status
end

get '/rlcarriers/' do
	erb :rlca_pro
	
    
end

post '/rlcarriers/' do
	pronumber = params[:pronumber]

	escaped_pro = CGI.escape(pronumber.strip)
    url = "http://www2.rlcarriers.com/freight/shipping/shipment-tracing?pro=#{escaped_pro}&docType=PRO"
    data = Nokogiri::HTML(open(url))
	@eta = data.css(".status").text
	@stat = data.css(".short-status").text
	@title = data.at_css("title").text
	@link = url
	@pro = pronumber
	@img = "http://i.imgur.com/9XmElZD.jpg"

	erb :status
end







