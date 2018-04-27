<%@page import="modelo.Editora"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Autor"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="dao.AutorDAO"%>
<%@page import="util.StormData"%>
<%@page import="modelo.Categoria"%>
<%@page import="dao.LivroDAO"%>
<%@page import="modelo.Livro"%>
<%
    String msg = "";
    String classe = "";
    
    if(request.getMethod().equals("POST")){
        String[] autoresid = request.getParameter("autores").split(";");
        Livro l = new Livro();
        l.setNome("As maravilhas da Programação");
        l.setDatapublicacao(new Date());
        l.setPreco(13.12f);
    
        List<Autor>listaautores = new ArrayList<>();
            for(String id : autoresid){
            Integer idinteger = Integer.parseInt(id);
            listaautores.add(new Autor());
    }
            
        l.setAutorList(listaautores);
        LivroDAO obj = new LivroDAO();
        dao.incluir(l);
        
    }
    Livro obj = new Livro();
    LivroDAO dao = new LivroDAO();
    Categoria cat = new Categoria();
    Editora edi = new Editora();
    Autor aut = new Autor();
    Categoria
    
    
    
    
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
                        <label>Autores</label>
                        <select name ="autores" multiple>
                            <%for(Autor a:autores){%>
                            <option value ="<%=a.getId()%>"><%=a.getNome()%>
                            </option>
                            <%}%>
                        </select>
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