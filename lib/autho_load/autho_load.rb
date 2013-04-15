module AuthoLoad
  def autho_load(params, cu)
    case params [:action]      
      when 'destroy', 'edit', 'show' 
        self.find(params[:id]).send("#{params[:action]}able_by", cu)        
      when 'update'
         r = self.find(params[:id])
         r.assign_attributes(params[self.model_name.downcase.to_sym])
         r.send("#{params[:action]}able_by", cu) 
      when 'create'
         self.new(params[self.model_name.downcase.to_sym]).send("#{params[:action]}able_by", cu)           
      when 'index', 'new'
        send("#{params[:action]}able_by", cu)                
    end
  end
end