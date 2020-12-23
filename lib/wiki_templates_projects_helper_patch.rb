module WikiTemplatesProjectsHelperPatch
  def self.prepend(base)
    base.send(:prepend, InstanceMethods)
    base.class_eval do
      unloadable      
      alias_method :project_settings_tabs_without_wiki_templates, :project_settings_tabs
      alias_method :project_settings_tabs, :project_settings_tabs_with_wiki_templates
    end
  end

  module InstanceMethods
    def project_settings_tabs_with_wiki_templates
      tabs = project_settings_tabs_without_wiki_templates
      tabs << {
        :name => 'wiki_templates',
        :partial => 'wiki_templates/index',
        :label => :project_module_wiki_templates
      } if @project.module_enabled?(:wiki_templates) and User.current.allowed_to?(:manage_wiki_templates, @project)
      tabs
    end
  end
end
