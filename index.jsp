<%@ taglib prefix='c' uri='http://java.sun.com/jstl/core'%>
<%@ page language="java"
    import="
            org.pentaho.platform.engine.core.system.PentahoSystem,
            org.pentaho.platform.api.engine.IPentahoSession,
			      org.pentaho.platform.api.engine.IPluginManager,
            java.util.List,
            org.pentaho.platform.engine.core.system.PentahoSessionHolder,
            java.util.ResourceBundle,
            org.owasp.esapi.ESAPI,
            java.net.URLClassLoader, java.net.URL"
%>
<%@page import="org.pentaho.platform.api.engine.IPentahoSession" %>
<%@page import="org.pentaho.platform.web.http.PentahoHttpSessionHelper" %>
<%@page import="org.pentaho.platform.api.engine.security.userroledao.IPentahoRole" %>
<%@page import="org.pentaho.platform.api.engine.security.userroledao.IPentahoUser" %>
<%@page import="org.pentaho.platform.api.engine.security.userroledao.IUserRoleDao" %>
<%@page import="java.util.ArrayList" %>
<% 
IPentahoSession userSession = PentahoSessionHolder.getSession();
String username = userSession.getName().toString();
IUserRoleDao userRoleDao = PentahoSystem.get( IUserRoleDao.class, "userRoleDaoProxy", PentahoSessionHolder.getSession());
List<IPentahoRole> userRoles = userRoleDao.getUserRoles( null, username );
List<String> listRoles = new ArrayList<String>();
for ( IPentahoRole role : userRoles ) {
      listRoles.add(role.getName());
}
if(listRoles.contains("Administrator")) {
	String url = "/pentaho/Home" ;
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location", url);
} else {
    //String url = "/pentaho/plugin/Gladiator/api/index" ; //Plugin Gladiator criado por Marco Antonio Smanioto
	String url = "/pentaho/content/saiku-ui/index.html?biplugin5=true" ; //Inicializacao direta no Saiku
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location", url);
}
%>
