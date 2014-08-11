module FrontHelper
  def browser_detection
    result  = request.env['HTTP_USER_AGENT']
    browser = ''
    begin
      if result =~ /OPR/
        browser = "Opera Opera-#{ result.split('OPR/')[1].split(' ').first.split('.').first }"
      elsif result =~ /Safari/
        unless result =~ /Chrome/
          browser = "Safari Safari-#{ result.split('Version/')[1].split(' ').first.split('.').first }"
        else
          browser = "Chrome Chrome-#{ result.split('Chrome/')[1].split(' ').first.split('.').first }"
        end
      elsif result =~ /Firefox/
        browser = "Firefox Firefox-#{ result.split('Firefox/')[1].split('.').first }"
      elsif result =~ /Opera/
        browser = "Opera Opera-#{ result.split('Version/')[1].split('.').first }"
      elsif result =~ /MSIE/
        browser = "InternetExplorer MSIE-#{ result.split('MSIE')[1].split(' ').first }"
      elsif result =~ /Trident/
        browser = "InternetExplorer MSIE-#{ result.split('rv:')[1].split('.').first }"
      end
    rescue
    end
    return browser
  end
end
