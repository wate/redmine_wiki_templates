class CreateWikiTemplates < ActiveRecord::Migration[4.2]
  def change
    create_table :wiki_templates do |t|
      t.integer    :author_id, :default => 0, :null => false
      t.text       :text
      t.string     :name, :default => "", :null => false
      t.integer    :project_id, :default => 0, :null => false
      t.boolean    :is_public, :default => false, :null => false
      t.timestamps :null => false
    end

    add_index :wiki_templates, :project_id
  end
end
