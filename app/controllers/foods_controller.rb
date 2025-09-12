class FoodsController < ApplicationController
  before_action :set_food, only: %i[ show edit update destroy ]

  # GET /foods or /foods.json
  def index
    @foods = Food.order(elo: :desc)
  end

  # GET /foods/1 or /foods/1.json
  def show
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
    @food2 = Food.find((Food.pluck(:id) - [ @food.id ]).sample)
  end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: "Food was successfully created." }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    food2 = Food.find(params.expect(food: [ :id2 ])["id2"])
    if params.expect(food: [ :id2 ])["food1_win"]
      @food.win(food2)
      food2.loss(@food)
    else
      @food.lose(food2)
      food2.win(@food)
    end
    next_foods = Food.all.sample(2)
    redirect_to(edit_food_path(id: next_foods[0].id))
  end

  def random_edit
    food = Food.order("RANDOM()").first
    redirect_to edit_food_path(food)
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy!

    respond_to do |format|
      format.html { redirect_to foods_path, notice: "Food was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def food_params
      params.expect(food: [ :name, :image_filename, :elo ])
    end
end
