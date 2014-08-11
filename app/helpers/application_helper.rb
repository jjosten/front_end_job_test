module ApplicationHelper
  # => include FrontHelper

  def icon( icn, txt = "" )
    raw("<i class='icon-#{icn}#{" #{txt}" if !txt.blank?}'></i>")
  end

  def glyphicon( icn, txt = "" )
    raw("<i class='glyphicon glyphicon-#{icn}#{" #{txt}" if !txt.blank?}'></i>")
  end

  def log( stuff = "# # # # # # # # # # # # # # #" )
    Rails.logger.info( stuff ) if Rails.env.development?
  end

  def error_msg( item )
    if item.errors.any?
      cls = item.class.to_s.parameterize("_")
      headline = I18n.t(  "errors.template.header",
                          count: item.errors.count,
                          model: I18n.t("activerecord.models.#{cls}", count: 1) )
      msgs = ""
      item.errors.each do |key, msg|
        if key.to_s.split(".").count > 1
          key = key.to_s.split(".")
          that = "#{I18n.t("activerecord.models.#{key[0]}", count: 1)}: #{I18n.t("helpers.label.#{key[0]}.#{key[1]}")}"
        else
          that = I18n.t("helpers.label.#{cls}.#{key}")
        end
        msgs += <<-HTML
                  <li>#{ icon("arrow-right") } <strong>#{ that }</strong> #{ msg }</li>
                HTML
      end
      html = <<-HTML
          <div class="error-box banderole">
            <div class="icn">
              #{ icon("info-round") }
            </div>
            <h4>#{ headline }</h4>
            <ul>
              #{ msgs }
            </ul>
          </div>
      HTML

      html.html_safe
    end
  end

  def invitation_link(class_names = '')
    if current_company && current_company.test_data == true
      link_to "Personal einladen", '#', class: class_names, 'alert-box' => I18n.t('invitation_not_possible')
    else
      link_to "Personal einladen", invite_company_users_path(current_company), class: class_names, data: { toggle: "modal", target: "#spptModal" } if current_company
    end
  end


  def google_font_tag( font, *args )
    options     = args.extract_options!
    html = <<-HTML
        <link href="//fonts.googleapis.com/css?family=#{font}#{'&subset=' + options[:subset] if !options[:subset].blank?}#{'&text=' + options[:text] if !options[:text].blank?}" rel="stylesheet" type="text/css" />
    HTML
    html.html_safe
  end

  def compare_colors(bg = "#fff", fg = "#000")
    # capture comand (stdout, stderror, status)
    o, e, s = Open3.capture3("compare -metric RMSE xc:'#{bg}' xc:'#{fg}' null:")
    if Rails.env.development?
      Rails.logger.info "***************************************"
      Rails.logger.info "***************************************"
      Rails.logger.info "$ compare -metric RMSE xc:'#{bg}' xc:'#{fg}' null:"
      Rails.logger.info "stdout: #{o}"
      Rails.logger.info "stderr: #{e}"
      Rails.logger.info "status: #{s}"
      Rails.logger.info "***************************************"
    end
    # output comes via standard error
    # fetch percentage from output e.g. "48520.2 (0.74037)" => 0.74037 %
    e = e.match(/.*\((.*)\).*/)[1] if e.match(/.*\((.*)\).*/)
    return e
  end

  def readable_color( clr )
    if compare_colors(clr).to_f > 0.5
      "#000"
    else
      "#fff"
    end
  end

end
