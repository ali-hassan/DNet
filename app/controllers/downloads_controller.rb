class DownloadsController < ApplicationController

  def index
    @filename = File.join(Rails.root, "public", "Presentation.pdf")
    send_file(@filename ,
              :type => 'pdf',
              :disposition => 'attachment')
  end
end
