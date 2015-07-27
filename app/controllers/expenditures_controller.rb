class ExpendituresController < ApplicationController
before_filter :authenticate_user!
  def index
    @expenditures = Expenditure.where(user_id: current_user.id)
  end

  def new
    if user_signed_in?
      @expenditure = Expenditure.new
    else
      redirect_to new_user_session_path
      flash.notice = "You need to sign in first"
    end
  end

  def create
    @expenditure = current_user.expenditures.build expenditure_params
    if @expenditure.save
      redirect_to expenditure_path(@expenditure)
    else
      render 'new'
    end
  end

  def show
    @expenditure = Expenditure.find(params[:id])
  end

  def destroy
    @expenditure = Expenditure.find params[:id]
    if @expenditure.user = current_user
      @expenditure.destroy
      redirect_to expenditure_path
      flash.notice = "Successful"
    else
      redirect_to expenditure_path
    end
  end


  private
    def expenditure_params
      params.require(:expenditure).permit(:name, :price, :quantity, :purchase_date)
    end
end
