class WorkersController < ApplicationController
  before_action :set_worker, except: [
    :index, :new, :create, :autocomplete_for
  ]
  before_action :authenticate_user!

  check_authorization
  load_and_authorize_resource

  # GET /workers
  def index
    @title = t('view.workers.index_title')
    @workers = Worker.all.page(params[:page])
  end

  # GET /workers/1
  def show
    @title = t('view.workers.show_title')
  end

  # GET /workers/new
  def new
    @title = t('view.workers.new_title')
    @worker = Worker.new
  end

  # GET /workers/1/edit
  def edit
    @title = t('view.workers.edit_title')
  end

  # POST /workers
  def create
    @title = t('view.workers.new_title')
    @worker = Worker.new(worker_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to @worker, notice: t('view.workers.correctly_created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /workers/1
  def update
    @title = t('view.workers.edit_title')

    respond_to do |format|
      if @worker.update(worker_params)
        format.html { redirect_to @worker, notice: t('view.workers.correctly_updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_worker_url(@worker), alert: t('view.workers.stale_object_error')
  end

  # DELETE /workers/1
  def destroy
    @worker.destroy
    redirect_to workers_url, notice: t('view.workers.correctly_destroyed')
  end

  def autocomplete_for
    workers = Worker.filtered_list(params[:q]).limit(5)

    respond_to do |format|
      format.json { render json: workers }
    end
  end

  def new_allotment
    @allotment = @worker.allotments.build
  end

  def create_allotment
    @allotment = @worker.allotments.build(allotment_params)

    if @allotment.save
      redirect_to @worker, notice: t('view.workers.allotment.correctly_created')
    else
      render action: 'new_allotment'
    end
  end

  def destroy_allotment
    allotment = @worker.allotments.find(params[:place_id])

    # TODO hacerlo mas bonito
    notice = allotment.destroy ? { notice: 'Ok' } : { alert: 'No se pudo eliminar' }
    redirect_to @worker, notice
  end

  private

    def set_worker
      @worker = Worker.find(params[:id])
    end

    def worker_params
      params.require(:worker).permit(
        :name, :last_name, :identification, :address, :phone, :occupation,
        :observations, :auto_worker_name, :parent_id, :auto_parent_name,
        allotments_attributes: [:id, :place]
      )
    end

    def allotment_params
      params.require(:allotment).permit(:place)
    end
end
