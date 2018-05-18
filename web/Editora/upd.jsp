
<%@page import="java.math.BigDecimal"%>
<%@page import="modelo.Editora"%>
<%@page import="dao.EditoraDAO"%>
<%@include file="../cabecalho.jsp" %>
<%
String msg ="";
String classe = "";
    
    EditoraDAO dao = new EditoraDAO();
    Editora obj = new Editora();
    //verifica se � postm ou seja, quer alterar
    if(request.getMethod().equals("POST")){
        
        //popular com oq ele digitou no form
        obj.setCnpj(request.getParameter("txtCnpj"));
        obj.setNome(request.getParameter("txtNome"));
        
        if(request.getParameter("txtLogo")!=null){
            obj.setLogo(request.getParameter("txtLogo"));
        }
        else{
            obj.setLogo(request.getParameter("txtLogoVelho"));
        }
                
        Boolean resultado = dao.alterar(obj);
        
        if(resultado){
            msg = "Registro alterado com sucesso";
            classe = "alert-success";
        }
        else{
            msg = "N�o foi poss�vel alterar";
            classe = "alert-danger";
        }
        
    }else{
        //e GET
        if(request.getParameter("id") == null){
            response.sendRedirect("index.jsp");
            return;
        }
        
        dao = new EditoraDAO();
        obj = dao.buscarPorChavePrimaria(request.getParameter("id"));
        
        if(obj == null){
            response.sendRedirect("index.jsp");
            return;
        } 
    }
%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Livraria Nathi
            <small>Admin</small>
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Listagem</a>
            </li>
            <li class="active">
                <i class="fa fa-file"></i> Aqui vai o conte�do de apresenta��o
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Editora
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="../UploadWS" method="post" enctype="multipart/form-data">
                
                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Cnpj</label>
                        <input class="form-control" type="text" name="txtCnpj" readonly value="<%=obj.getCnpj()%>"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text" name="txtNome" required value="<%=obj.getNome() %>" />
                    </div>
                    
                    <div class="form-group">
                        <label>Logo</label>
                        <input class="form-control" type="file" name="txtLogo" id="foto" accept="image/*" />
                        <img src="../arquivos/<%=obj.getLogo()%>" id="foto"/>
                        <input type="hidden" name="txtLogoVelho" valeu="<%=obj.getLogo()%>"/>
                    </div>
                    

                <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                
            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>
<script>
    function readURL(input,destino) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#'+destino).attr('src', e.target.result);
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#arquivo1").change(function(){
        readURL(this,"img1");
    });
</script>