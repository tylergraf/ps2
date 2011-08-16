class CheckInsController < ApplicationController
  # GET /check_ins
  # GET /check_ins.json
  def index
    @check_ins = CheckIn.all
    @days = CheckIn.get_past_check_ins(current_user.id, 8)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @check_ins }
    end
  end

  # GET /check_ins/1
  # GET /check_ins/1.json
  def show
    @check_in = CheckIn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @check_in }
    end
  end

  # GET /check_ins/get_checkin
  # GET /check_ins/get_checkin/1.json
  def get_checkin
    @check_in = CheckIn.where(:user_id => current_user.id,:date => params[:date])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @check_in }
    end
  end

  # GET /check_ins/new
  # GET /check_ins/new.json
  def new
    @check_in = CheckIn.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @check_in }
    end
  end

  # GET /check_ins/1/edit
  def edit
    @check_in = CheckIn.find(params[:id])
  end

  # POST /check_ins
  # POST /check_ins.json
  def create
    @check_in = CheckIn.new(params[:check_in])

    respond_to do |format|
      if @check_in.save
        format.html { redirect_to @check_in, notice: 'Check in was successfully created.' }
        format.json { render json: @check_in, status: :created, location: @check_in }
      else
        format.html { render action: "new" }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /check_ins/1
  # PUT /check_ins/1.json
  def update
    @check_in = CheckIn.find(params[:id])

    respond_to do |format|
      if @check_in.update_attributes(params[:check_in])
        format.html { redirect_to @check_in, notice: 'Check in was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /check_ins/1
  # DELETE /check_ins/1.json
  def destroy
    @check_in = CheckIn.find(params[:id])
    @check_in.destroy

    respond_to do |format|
      format.html { redirect_to check_ins_url }
      format.json { head :ok }
    end
  end
end
