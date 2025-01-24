class Api::V1::ApplicationsController < Api::V1::ApplicationController   
  before_action :set_application, only: [:update]

    def show
        render json: Application.find_by(token: params[:token]).as_json(:except => [:id])
      end
    
    def index
      render json: Application.all.as_json(:except => [:id])
    end

    def update
      if @application.update(name: application_params[:name])
        render json: { message: 'Application updated successfully', application: @application.as_json(:except => [:id]) }, status: :ok
      else
        render json: { error: 'Failed to update application', details: @application.errors.full_messages }, status: :unprocessable_entity
      end
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

   def set_application
    @application = Application.find_by(token: params[:token])
    render json: { error: 'Application not found' }, status: :not_found unless @application
   end

    def application_params
        params.require(:application).permit(:name)
    end

end
