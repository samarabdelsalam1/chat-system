class Api::V1::ApplicationsController < Api::V1::ApplicationController   
    
    def show
        render json: Application.find_by(token: params[:token]).as_json(:except => [:id])
      end
    
    def index
      render json: Application.all.as_json(:except => [:id])
    end
    
    def create
        application = Application.new(application_params)

        if application.save
          render json: application.as_json(:except => [:id]), status: :created
        else
          render json: { errors: application.errors.full_messages }, status: :unprocessable_entity
        end
    end

   private

    def application_params
        params.require(:application).permit(:name, :token)
    end

end
