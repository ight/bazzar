class BazzarSettings < Settingslogic

  # Load the source file for settings
  source "#{Rails.root}/config/bazzar.yml"
  namespace Rails.env

  def self.build_url
    custom_port = ":#{port}" unless [443.80].include?(port.to_i)
    app_path =
      [ protocol,
        "://",
        host,
        custom_port,
        relative_url_root
      ].join('')
  end
end

BazzarSettings['host'] ||= 'localhost'
BazzarSettings['relative_url'] ||= '/'
BazzarSettings['url'] ||= BazzarSettings.build_url