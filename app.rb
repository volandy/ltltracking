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
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
	escaped_pro = CGI.escape(i.strip)
	    url = "http://works.pittohio.com/mypittohio/pbetrace2.asp?pronumber=#{escaped_pro}"
		data = Nokogiri::XML(open(url)) 
	  	@values << [data.xpath("//currentstatus").text, data.at_xpath("//prostatus")['estimateddelivery'], data.at_xpath("//prostatus")['datedelivered'], i, "http://works.pittohio.com/mypittohio/OnlineTools/OT_ShipmentTrace_Details.asp?sessionid=6B8049BD-095F-4ADF-B176-E2639988816F&menuid=&pro=#{escaped_pro}&bol=&PP=0"]
	end

	@count = 0
	@img = "http://i.imgur.com/6699xFT.jpg"
	
	@title = "Delivered"
	erb :status
	

end

get '/daytonfreight/' do
	erb :dafg_pro
	
    
end

post '/daytonfreight/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
	escaped_pro = CGI.escape(i.strip)
	
	    url = "http://daytonfreight.com/Tracking/TrackingDetail.aspx?proNum=#{escaped_pro}"
		data = Nokogiri::HTML(open(url))
		@values << [data.xpath("//td[@id='tcLastActivity']").text, data.xpath("//*[(@id = 'tcEta')]").text, data.xpath("//*[(@id = 'tcLastActivityTime')]").text, i, "http://daytonfreight.com/Tracking/TrackingDetail.aspx?proNum=#{escaped_pro}"]
	end

	@count = 0
	@img = "http://i.imgur.com/nGaRqMq.jpg"
	@title = "Last Activity Time"

	erb :status
end

get '/newengland/' do
	erb :nemf_pro
	
    
end

post '/newengland/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
	    url = "http://nemfweb.nemf.com/shptrack.nsf/request?openagent=1&pro=#{escaped_pro}&submit=Track"
		data = Nokogiri::HTML(open(url))
		@values << [data.css("td:nth-child(1)").text[8..-1], data.css("td:nth-child(2)").text[8..-1], data.css("td:nth-child(2)").text[8..-1], i, "http://nemfweb.nemf.com/shptrack.nsf/request?openagent=1&pro=#{escaped_pro}&submit=Track"]
		
	end

	@title = "Last Activity Time"
	@img = "http://i.imgur.com/gFviT8j.jpg"
	@count = 0

	erb :status
end

get '/olddominion/' do
	erb :odfl_pro
	
    
end

post '/olddominion/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
		url = "http://www.odfl.com/Trace/standardResult.faces?pro=#{escaped_pro}"
		data = Nokogiri::HTML(open(url))
		@values << [data.xpath("//*[(@id = 'traceResult\:j_idt61')]").text, data.xpath("//*[(@id = 'traceResult\:j_idt53')]").text, data.xpath("//*[(@id = 'traceResult\:j_idt53')]").text, i, "http://www.odfl.com/Trace/standardResult.faces?pro=#{escaped_pro}"]
	end	

	
    
	@title = "Last Activity Time"
	@count = 0
	@img = "http://i.imgur.com/ZRVF2F0.jpg"

	erb :status
end

get '/centraltransport/' do
	erb :ctii_pro
	
    
end

post '/centraltransport/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
		url = "http://www.centraltransport.com/Confirm/trace.aspx?pro=#{escaped_pro}"
		data = Nokogiri::HTML(open(url))
		@values << [data.css(".hh~ .hh+ .hh").text, data.css(".dates~ .dates+ .dates").text, data.css(".dates~ .dates+ .dates").text, i, "http://www.centraltransport.com/Confirm/trace.aspx?pro=#{escaped_pro}"]
	end

	
   
	@title = "Last Activity Time"
	@count = 0
	@img = "http://i.imgur.com/oJx2fug.jpg"

	erb :status
end

get '/aduiepyle/' do
	erb :pyle_pro
	
    
end

post '/aduiepyle/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
    	url = "http://aduiepyle.com/LTL/ShipmentTracking?Pro=#{escaped_pro}"
		data = Nokogiri::HTML(open(url))
		@values << [data.xpath('//*[(@id = "MainContent_Repeater1_lblStatus_0")]').text, data.xpath('//*[(@id = "MainContent_Repeater1_lblDelivered_0")]').text, data.xpath('//*[(@id = "MainContent_Repeater1_lblDelivered_0")]').text, i, "http://aduiepyle.com/LTL/ShipmentTracking?Pro=#{escaped_pro}"]
	end
	@title = "Last Activity Time"
	@count = 0
	@img = "http://i.imgur.com/iPJtdpd.jpg"

	erb :status
end

get '/southeastfreightlines/' do
	erb :sefl_pro
	
    
end

post '/southeastfreightlines/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
    	url = "https://sefl.com/seflWebsite/servlet?Type=PN&login=null&ZipCode=00000&IntranetAcctCallId=&seflMenuUsername=&GUID=&seflMenuEmployeeLocation=&action=Tracing_Trace_by_pro&externalMenu=true&wantsToBeSecure=Y&EMP_GUID=null&RefNum=#{escaped_pro}&seflMenuEmployeeID=&Protocol_Changed=true"
    	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
		data = Nokogiri::HTML(open(url))
		@values << [data.xpath("//*[@id='resultsTable']/tbody/tr[12]/td[4]/text()[1]").text, data.xpath("//*[@id='resultsTable']/tbody/tr[16]/td[4]").text, data.xpath("//*[@id='resultsTable']/tbody/tr[16]/td[4]").text, i, "https://sefl.com/seflWebsite/servlet?Type=PN&login=null&ZipCode=00000&IntranetAcctCallId=&seflMenuUsername=&GUID=&seflMenuEmployeeLocation=&action=Tracing_Trace_by_pro&externalMenu=true&wantsToBeSecure=Y&EMP_GUID=null&RefNum=#{escaped_pro}&seflMenuEmployeeID=&Protocol_Changed=true"]
	end
	@title = "Last Activity Time"
	@count = 0
	@img = "http://i.imgur.com/iOJnQ5b.jpg"

	erb :status
end

get '/centralfreight/' do
	erb :cenf_pro
	
    
end

post '/centralfreight/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
    	url = "http://centralfreight.com/website/mf/mfInquiry.aspx?inqmode=PRO&pro=#{escaped_pro}"
		data = Nokogiri::HTML(open(url))
		@values << [data.xpath("//*[@id='main']/div[3]").text, data.xpath("//*[@id='main']/div[8]/text()").text, data.xpath("//*[@id='main']/div[8]/text()").text, i, "http://centralfreight.com/website/mf/mfInquiry.aspx?inqmode=PRO&pro=#{escaped_pro}"] 
	end
	@title = "Last Activity Time"
	@count = 0
    @img = "http://i.imgur.com/axcvMqv.jpg"

	erb :status
end



get '/abfs/' do
	erb :abfs_pro
	
    
end

post '/abfs/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
    	url = "https://www.abfs.com/tools/trace/default.asp?hidSubmitted=Y&refno0=#{escaped_pro}&reftype0=A"
    	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
		data = Nokogiri::HTML(open(url))
		@values << [data.css("#PageResults .formTxt").text, data.css("td+ td .dataTxt").text, data.css("td+ td .dataTxt").text, i, "https://www.abfs.com/tools/trace/default.asp?hidSubmitted=Y&refno0=#{escaped_pro}&reftype0=A"]
	end
	@title = "Last Activity Time"
	@count = 0
	@img = "http://i.imgur.com/VVVXwBi.jpg"

	erb :status
end

get '/roadrunner/' do
	erb :rdfs_pro
	
    
end



post '/roadrunner/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
    	url = "https://www.rrts.com/Tools/Tracking/Pages/MultipleResults.aspx?PROS=#{escaped_pro}"
    	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE 
		data = Nokogiri::HTML(open(url))
		@values << [data.xpath("//*[(@id = 'ctl00_ctl50_g_a00bf657_07a9_444e_9b38_fb00487e0952_TraceResultID343057055_lblDeliveredDate')]").text, data.xpath("//*[(@id = 'ctl00_ctl50_g_a00bf657_07a9_444e_9b38_fb00487e0952_TraceResultID343057055_lblProjectedDeliveryDate')]"), data.xpath("//*[(@id = 'ctl00_ctl50_g_a00bf657_07a9_444e_9b38_fb00487e0952_TraceResultID343057055_lblDeliveredDate')]").text, i, "https://www.rrts.com/Tools/Tracking/Pages/MultipleResults.aspx?PROS=#{escaped_pro}"]
	end
	
	@title = "Delivery Date"
	@count = 0
	@img = "http://i.imgur.com/KPaDHHv.jpg"

	erb :status
end

get '/aaacooper/' do
	erb :aact_pro
	
    
end

post '/aaacooper/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
    	url = "http://www.aaacooper.com/Transit/ProTrackResults.aspx?ProNum=#{escaped_pro}&AllAccounts=true"
    	data = Nokogiri::HTML(open(url))
    	@values << [data.css("#AAACooperMasterPage_bodyContent_lblDeliveryStatus").text, data.css("#AAACooperMasterPage_bodyContent_lblDeliveryDate").text, data.css("#AAACooperMasterPage_bodyContent_lblDeliveryDate").text, i, url = "http://www.aaacooper.com/Transit/ProTrackResults.aspx?ProNum=#{escaped_pro}&AllAccounts=true"]
	end
	@title = "Last Activity Time"
	@count = 0
	@img = "http://i.imgur.com/HrgU7TS.jpg"

	erb :status
end




get '/dohrn/' do
	erb :dohrn_pro
	
    
end

post '/dohrn/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
	    url = "http://www.dohrn.com/scripts/cgiip.exe/boldetail.htm?wbtn=PRO&wpro1=#{escaped_pro}&seskey=&nav=&language="
	    data = Nokogiri::HTML(open(url))
	    @values << [data.xpath("//*[@id='hist.0x000000001594b9ee']/table/tbody/tr[1]/td[1]").text, data.xpath("//*[@id='hist.0x000000001594b9ee']/table/tbody/tr[1]/td[3]").text, data.xpath("//*[@id='hist.0x000000001594b9ee']/table/tbody/tr[1]/td[3]").text, i, "http://www.dohrn.com/scripts/cgiip.exe/boldetail.htm?wbtn=PRO&wpro1=#{escaped_pro}&seskey=&nav=&language="]
	end

	@img = "http://i.imgur.com/2qG8jtN.jpg"
	@title = "Last Activity Time"
	@count = 0
	erb :status
end





get '/rlcarriers/' do
	erb :rlca_pro
	
    
end

post '/rlcarriers/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
	    url = "http://www2.rlcarriers.com/freight/shipping/shipment-tracing?pro=#{escaped_pro}&docType=PRO"
	    data = Nokogiri::HTML(open(url))
	    @values << [data.css(".short-status").text, data.xpath("//*[@id='result-container']/div[1]/text()").text, data.xpath("//*[@id='result-container']/div[1]/text()").text, i, "http://www2.rlcarriers.com/freight/shipping/shipment-tracing?pro=#{escaped_pro}&docType=PRO"] 
	end
	
	@img = "http://i.imgur.com/WEQ7ken.jpg"
	@title = "Last Activity Time"
	@count = 0
	
	erb :status
end

get '/ups/' do
	erb :ups_pro
	
    
end

post '/ups/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
	    url = "http://ltl.upsfreight.com/shipping/tracking/TrackingDetail.aspx?TrackProNumber=#{escaped_pro}"
	    data = Nokogiri::HTML(open(url))
	    @values << [data.xpath("//*[@id='app_ctl00_lblDeliverStatus']").text, data.xpath("//*[@id='app_ctl00_lblScheduledDelivery']").text, data.xpath("//*[@id='app_ctl00_lblDeliveredOn']").text, i, "http://ltl.upsfreight.com/shipping/tracking/TrackingDetail.aspx?TrackProNumber=#{escaped_pro}"] 
	end
	
	@img = ""
	@title = "Delivered"
	@count = 0
	
	erb :status
end

get '/saia/' do
	erb :saia_pro
	
    
end

post '/saia/' do
	@pronumbers = params[:pronumber].split(" ")
	@values = []
	for i in @pronumbers
		escaped_pro = CGI.escape(i.strip)
	    url = "http://www.saiasecure.com/tracing/b_manifest.asp?pro=#{escaped_pro}"
	    data = Nokogiri::HTML(open(url))
	    @values << [data.css("hr+ table font b").text, data.css("hr+ table tr:nth-child(10) td+ td font").text, data.css("tr:nth-child(15) td+ td font").text, i, "http://www.saiasecure.com/tracing/b_manifest.asp?pro=#{escaped_pro}"] 
	end
	
	@img = ""
	@title = "Delivered"
	@count = 0
	
	erb :status
end










