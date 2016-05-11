require_dependency "email_me/application_controller"

module EmailMe
  class MailTemplatesController < ApplicationController
    before_action :set_mail_template, only: [:show, :edit, :update, :destroy]

    # GET /mail_templates
    def index
      @mail_templates = MailTemplate.all
    end

    # GET /mail_templates/1/edit
    def edit
      @replacement_fields = EmailMe.replacement_fields
    end

    def preview
      # TODO figure out renderer options, and make as a class variable?
      content = preview_params[:content]
      @preview_html = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(content)
      respond_to do |format|
        format.html { render :preview, layout: false }
      end
    end

    # PATCH/PUT /mail_templates/1
    def update
      if @mail_template.update(mail_template_params)
        redirect_to mail_templates_path, notice: "Mail template successfully updated"
      else
        render :edit
        flash.now notice: "An error occurred updating the template."
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_mail_template
        @mail_template = MailTemplate.find(params[:id])
      end

      def preview_params
        params.permit(:content)
      end

      # Only allow a trusted parameter "white list" through.
      def mail_template_params
        params.require(:mail_template).permit(:name, :description, :subject, :content)
      end
  end
end
