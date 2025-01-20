class ApplicationsController < ApplicationController   
    
    def show
        application = Application.find_by!(token: params[:token])
        render json: JsonSerializer.serialize application
      end
    
    def index
      render json: JsonSerializer.serialize Application.all
    end
    
    def create
        application = Application.new(application_params)

        if application.save
          render json: JsonSerializer.serialize application, status: :created
        else
          render json: { errors: application.errors.full_messages }, status: :unprocessable_entity
        end
    end
   
    def application_params
        params.permit(:name)
    end

end
