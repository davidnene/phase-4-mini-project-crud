class SpicesController < ApplicationController
    #Get /spices
    def index
        spices = Spice.all 
        render json: spices
    end

    #POST /spices/
    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    #PATCH /spices/:id
    def update
        spice = Spice.find_by(id: params[:id])
        
        if spice
            spice.update(spice_params)
            render json: spice
        else
            render json: {"error":"Spice not found"}, status: :not_found
        end
    end

    #DELETE /spices/:id
    def destroy
        spice = Spice.find_by(id: params[:id])

        if spice
            spice.destroy
            head :no_content
        else
            render json: {"error":"Spice not found"}, status: :not_found
        end
    end

    #Increment rating
    def increment_rating
        spice = Spice.find_by(id: params[:id])

        if spice
            spice.update(rating: spice.rating + 1)
            render json: spice
        else
            render json: {"error": "Spice not found"}
        end
    end


    private
    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
end
