module MongoidShortener
  class ShortenedUrlsController < ApplicationController
    # find the real link for the shortened link key and redirect
    def translate
      # pull the link out of the db
      sl = ShortenedUrl.where(:unique_key => params[:unique_key][1..-1]).first

      if sl
        # sl.inc(:use_count, 1)
        # do a 301 redirect to the destination url
        respond_to do |format|
          format.html do
            # head :moved_permanently, :location => sl.url and return
            ids = sl.url.split("/")[-1].split(',')
            hid = ids[0]
            qid = ids[1]
            redirect_to "/student/questions/#{qid}?hid=#{hid}" and return
          end
          format.json do
            ids = sl.url.split("/")[-1].split(',')
            hid = ids[0]
            qid = ids[1]
            render json: { success: true, homework_id: hid, question_id: qid } and return
          end
        end
      else
        # if we don't find the shortened link, redirect to the root
        # make this configurable in future versions
        respond_to do |format|
          format.html do
            head :moved_permanently, :location => MongoidShortener.root_url and return
          end
          format.json do
            render json: ErrCode.ret_false(ErrCode::QUESTION_NOT_EXIST) and return
          end
        end
      end
    end
  end
end
