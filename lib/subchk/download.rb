
class File

  SUBTITLES_FILETYPES = ['txt', 'srt']

  def self.has_subtitles?(f)
    SUBTITLES_FILETYPES.any? { |sub_ext| 
      subs_filename = File.join(File.dirname(f), File.basename(f, '.*') + '.' + sub_ext)
      File.exists?(subs_filename)
    }
  end

end

module Subchk

  class MissingSubtitlesDownloader

    VIDEO_FILETYPES = ['mkv', 'avi', 'mp4']

    def initialize(dir, notifier)
      @dir = dir
      @notifier = notifier
    end

    def collect_video_files
      VIDEO_FILETYPES.map { |video_ftype| Dir.glob(@dir + '/**/*.' + video_ftype) }.flatten
    end

    def collect_video_files_without_subtitles
      collect_video_files.select do |f| 
        !File.has_subtitles?(f)
      end
    end

    def download_missing_subtitles
      collect_video_files_without_subtitles.each do |f|
        cmd = "qnapi -q \"#{f}\""
        result = system(cmd)

        if result and File.has_subtitles?(f)
          short = File.basename(f)
          @notifier.notify "Subs downloaded: #{short}", "Successfully downloaded subtitles for #{short}."
        end
      end
    end

  end
end
