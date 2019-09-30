class DegreeToBookMappingsController < ApplicationController
  before_action :set_degree_to_book_mapping, only: [:show, :edit, :update, :destroy]

  # GET /degree_to_book_mappings
  # GET /degree_to_book_mappings.json
  def index
    @degree_to_book_mappings = DegreeToBookMapping.all
  end

  # GET /degree_to_book_mappings/1
  # GET /degree_to_book_mappings/1.json
  def show
  end

  # GET /degree_to_book_mappings/new
  def new
    @degree_to_book_mapping = DegreeToBookMapping.new
  end

  # GET /degree_to_book_mappings/1/edit
  def edit
  end

  # POST /degree_to_book_mappings
  # POST /degree_to_book_mappings.json
  def create
    @degree_to_book_mapping = DegreeToBookMapping.new(degree_to_book_mapping_params)

    respond_to do |format|
      if @degree_to_book_mapping.save
        format.html { redirect_to @degree_to_book_mapping, notice: 'Degree to book mapping was successfully created.' }
        format.json { render :show, status: :created, location: @degree_to_book_mapping }
      else
        format.html { render :new }
        format.json { render json: @degree_to_book_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /degree_to_book_mappings/1
  # PATCH/PUT /degree_to_book_mappings/1.json
  def update
    respond_to do |format|
      if @degree_to_book_mapping.update(degree_to_book_mapping_params)
        format.html { redirect_to @degree_to_book_mapping, notice: 'Degree to book mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @degree_to_book_mapping }
      else
        format.html { render :edit }
        format.json { render json: @degree_to_book_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /degree_to_book_mappings/1
  # DELETE /degree_to_book_mappings/1.json
  def destroy
    @degree_to_book_mapping.destroy
    respond_to do |format|
      format.html { redirect_to degree_to_book_mappings_url, notice: 'Degree to book mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_degree_to_book_mapping
      @degree_to_book_mapping = DegreeToBookMapping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def degree_to_book_mapping_params
      params.require(:degree_to_book_mapping).permit(:educational_level, :book_count)
    end
end
