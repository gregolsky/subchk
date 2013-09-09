
require 'yaml'
require 'subchk/download'
require 'subchk/notify'

module Subchk

  class Program

    CFG_FILE = '~/.subchk'

    def run
      cfg = load_config
      smtp_cfg = cfg['smtp']
      notifier = SmtpNotifier.new smtp_cfg['host'], smtp_cfg['port'].to_i, smtp_cfg['username'], smtp_cfg['password'], cfg['email']
      subchk = MissingSubtitlesDownloader.new cfg['check directory'], notifier
      subchk.download_missing_subtitles
    end

    def cfg_path
      File.expand_path(CFG_FILE)
    end 

    def create_config
        cfg = {
            'check directory' => '',
            'smtp' => { 'host' => '', 'port' => '', 'username' => '', 'password' => '' },
            'email' => ''
        }
        
        File.open(cfg_path, 'w') { |f| f.write(YAML.dump(cfg)) }
        puts 'Setup your ~/.subchk file and run again.'
        exit 0
    end

    def load_config
      if File.exists? cfg_path
        cfg = YAML.load_file(cfg_path)
      else
        create_config
      end
    end

  end

end
