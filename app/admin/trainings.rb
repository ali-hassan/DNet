ActiveAdmin.register Training, as: "Training" do

  permit_params :video_url, :heading
  index do
    column :heading
    column "Video URL" do |training|
      raw "<iframe src=\"https://www.youtube.com/embed/#{training.video_url.scan(/v\=.*/).first.split("&").first.gsub("v=", "") }\" class=\"listing-description-youtube-iframe\"></iframe>"
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :heading
      f.input :video_url
    end
    actions
  end

end
