require 'rexml/document'
doc = REXML::Document.new File.new 'alm-webapp.ipr'
m = doc.elements['//module']
newm = REXML::Element.new 'module'
newm.attributes['fileurl'] = 'file://$PROJECT_DIR$/../alm-tool-guitest/alm-tool-guitest.iml'
newm.attributes['filepath'] = '$PROJECT_DIR$/../alm-tool-guitest/alm-tool-guitest.iml'
doc.root.insert_after m, newm
doc.write File.new 'alm-webapp-fixed.ipr'

