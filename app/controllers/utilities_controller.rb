class UtilitiesController < ApplicationController
    #Smart_listing
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper
  def index
    @departments = smart_listing_create(:departments, Department.all, partial: "departments/smart_listing/list", default_sort: {id: "asc"},  page_sizes: [10,20,30,50])
  end

end
