<%--
* This program is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License, version 2.1 as published by the Free Software
* Foundation.
*
* You should have received a copy of the GNU Lesser General Public License along with this
* program; if not, you can obtain a copy at http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
* or from the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
* This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
* without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
* See the GNU Lesser General Public License for more details.
*
* Copyright (c) 2002-2013 Pentaho Corporation..  All rights reserved.
--%>

<%@ taglib prefix='c' uri='http://java.sun.com/jstl/core'%>
<%@ page language="java"
    import="
            org.pentaho.platform.engine.core.system.PentahoSystem,
            org.pentaho.platform.api.engine.IPentahoSession,
			      org.pentaho.platform.api.engine.IPluginManager,
            java.util.List,
            org.pentaho.platform.engine.core.system.PentahoSessionHolder,
            java.util.ResourceBundle,
            org.owasp.encoder.Encode,
            java.net.URLClassLoader, java.net.URL"
%>

<%@page import="org.pentaho.platform.api.engine.IPentahoSession" %>
<%@page import="org.pentaho.platform.web.http.PentahoHttpSessionHelper" %>
<%@page import="org.pentaho.platform.api.engine.security.userroledao.IPentahoRole" %>
<%@page import="org.pentaho.platform.api.engine.security.userroledao.IPentahoUser" %>
<%@page import="org.pentaho.platform.api.engine.security.userroledao.IUserRoleDao" %>
<%@page import="java.util.ArrayList" %>
			
<html>
  <head>
  <% 
  URLClassLoader loader = new URLClassLoader( new URL[] { application.getResource( "/mantle/messages/" ) } );
  ResourceBundle properties = ResourceBundle.getBundle( "mantleMessages", request.getLocale(), loader );
%>
    
    <title><%= properties.getString("pentahoBATitle") %></title>    

    <script type="text/javascript" src="webcontext.js"></script>

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
    String url = "/pentaho/plugin/Gladiator/api/index" ; //Plugin Gladiator criado por Marco Antonio Smanioto
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location", url);
}


	%>
	
  </head>
  <body>
  </body>
</html>
