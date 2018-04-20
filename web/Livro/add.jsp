<%@page import="util.StormData"%>
<%@page import="modelo.Categoria"%>
<%@page import="dao.LivroDAO"%>
<%@page import="modelo.Livro"%>
<%
    String msg = "";
    String classe = "";
    Livro obj = new Livro();
    LivroDAO dao = new LivroDAO();
    Categoria c = new Categoria();
    
    if (request.getParameter("txtNome") != null && request.getParameter("txtCnpj") != null 
            && request.getParameter("txtPreco") != null && request.getParameter("txtDataPublicacao") !=null
            && request.getParameter("Categoria") !=null && request.getParameter("Editora") !=null) {
        obj.setNome(request.getParameter("txtNome"));
        c.setNome(request.getParameter("txtCategoria"));
        obj.setCategoria(c);
        obj.setDatapublicacao(StormData.formata(request.getParameter("txtData)));
        obj.setPreco(request.getParameter("txtCnpj"));
        obj.setDatapublicacao(request.getParameter("txtFoto"));
        obj.setEditora(editora);
        obj.setImagem1(imagem1);
        obj.setImagem2(imagem2);
        obj.setImagem3(imagem3);
        obj.setSinopse(sinopse);
        
        Boolean resultado = dao.incluir(obj);
        if (resultado) {
            msg = "Registro cadastrado com sucesso";
            classe = "alert-success";
        } else {
            msg = "Não foi possível cadastrar";
            classe = "alert-danger";
        }
    } 
    

%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Sistema de Livros
            <small>Admin</small>
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Área Administrativa</a>
            </li>
            <li class="active">
                <i class="fa fa-file"></i> Aqui vai o conteúdo de apresentação 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Livros
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
                <form action="../UploadWS" method="post" enctype="multipart/form-data">


                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text"  name="txtNome"  required />
                    </div>
                    
                    <div class="form-group">
                        <label>Cnpj</label>
                        <input class="form-control" type="text"  name="txtCnpj"  required />
                    </div>
                    
                    <div class="form-group">
                        <label>Logo</label>
                        <input type="file"  name="Foto" />
                    </div>
                   
                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- 1/.row -->
<%@include file="../rodape.jsp" %>