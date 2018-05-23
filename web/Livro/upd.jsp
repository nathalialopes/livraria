<%@page import="java.util.ArrayList"%>
<%@page import="util.StormData"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Editora"%>
<%@page import="modelo.Categoria"%>
<%@page import="modelo.Livro"%>
<%@page import="dao.EditoraDAO"%>
<%@page import="dao.CategoriaDAO"%>
<%@page import="dao.LivroDAO"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="modelo.Autor"%>
<%@page import="dao.AutorDAO"%>
<%@include file="../cabecalho.jsp" %>
<%
String msg ="";
String classe = "";
    
    LivroDAO dao = new LivroDAO();
    Livro obj = new Livro();
    Categoria cat = new Categoria();
    Editora edi = new Editora();
    
    CategoriaDAO cdao = new CategoriaDAO();
    List<Categoria> clista = cdao.listar();
    
    EditoraDAO edao = new EditoraDAO();
    List<Editora> elista = edao.listar();
    
    AutorDAO adao = new AutorDAO();
    List<Autor> alista = adao.listar();
       
    
    //verifica se � postm ou seja, quer alterar
    if(request.getMethod().equals("POST")){
        
        obj.setId(Integer.parseInt(request.getParameter("txtId")));
        obj.setNome(request.getParameter("txtNome"));
        obj.setPreco(Float.parseFloat(request.getParameter("txtPreco")));
        obj.setDatapublicacao(StormData.formata(request.getParameter("txtData")));
        obj.setSinopse(request.getParameter("txtSinopse"));
        
        cat.setId(Integer.parseInt(request.getParameter("txtCategoria")));
        edi.setCnpj(request.getParameter("txtEditora"));
        
        obj.setCategoria(cat);
        obj.setEditora(edi);
        
        if(request.getParameter("txtImagem1")!=null){
            obj.setImagem1(request.getParameter("txtImagem1"));
        }
        else{
            obj.setImagem1(request.getParameter("txtFotoVelha1"));
        }
        if(request.getParameter("txtImagem2")!=null){
            obj.setImagem2(request.getParameter("txtImagem2"));
        }
        else{
            obj.setImagem2(request.getParameter("txtFotoVelha2"));
        }
        if(request.getParameter("txtImagem3")!=null){
            obj.setImagem3(request.getParameter("txtImagem3"));
        }
        else{
            obj.setImagem3(request.getParameter("txtFotoVelha3"));
        }

        String[] autoresid = request.getParameter("autores").split(";");
        List<Autor>listaautores = new ArrayList<>();
        for(String id : autoresid){
            Integer idinteger = Integer.parseInt(id);
            listaautores.add(new Autor(idinteger));
        }
        
        obj.setAutorList(listaautores);
                                       
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
        
        dao = new LivroDAO();
        obj = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("id")));
        
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
            Autor
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="../UploadWS" method="post" enctype="multipart/form-data">
                
                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Id</label>
                        <input class="form-control" type="text" name="txtId" readonly value="<%=obj.getId()%>"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text"  name="txtNome"  required value ="<%=obj.getNome()%>"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Sinopse</label>
                        <textarea class="form-control" required name="txtSinopse"><%=obj.getSinopse()%>
                        </textarea>
                    </div>
                        
                    <div class="form-group">
                        <label>Foto</label>
                        <input type="file" name="txtImagem1" value="<%=obj.getImagem1()%>" id="arquivo1"  accept="image/*" />
                        <img src="../arquivos/<%=obj.getImagem1()%>" id="img1"/>
                        <input type="hidden" name="txtFotoVelha1" value="<%=obj.getImagem1()%>"/>
                    </div>

                    <div class="form-group">
                        <label>Foto 2</label>
                        <input type="file" name="txtImagem2" value="<%=obj.getImagem2()%>" id="arquivo1"  accept="image/*" />
                        <img src="../arquivos/<%=obj.getImagem2()%>" id="img1"/>
                        <input type="hidden" name="txtFotoVelha2" value="<%=obj.getImagem2()%>"/>
                    </div>

                    <div class="form-group">
                        <label>Foto 3</label>
                        <input type="file" name="txtImagem3" value="<%=obj.getImagem3()%>" id="arquivo1"  accept="image/*" />
                        <img src="../arquivos/<%=obj.getImagem3()%>" id="img1"/>
                        <input type="hidden" name="txtFotoVelha3" value="<%=obj.getImagem3()%>"/>
                    </div>    
                        
                    <div class="form-group">
                        <label>Pre�o</label>
                        <input class="form-control" type="text"  name="txtPreco"  required value="<%=obj.getPreco()%>" />
                    </div>
                    
                    

                    <div class="form-group">
                        <label>Data Publica��o</label>
                        <input class="form-control" type="text"  name="txtData" required value="<%=StormData.formata(obj.getDatapublicacao())%>"/>
                    </div>
                   
                    <div class="form-group">
                        <label>Editora</label>
                        <input class="form-control" type="text"  name="txtEditora"  required />
                    </div>
                                       
                    <div class="form-group">
                        <label>Autores</label>
                        <select name="autores" multiple value="<%=obj.getAutorList()%>">
                            <%
                                String selecionadoo;
                                for(Autor a : alista) {
                                    if(obj.getAutorList().contains(a)){
                                        selecionadoo = "selected";
                                    }
                                else{
                                        selecionadoo="";
                                        }
                             %>
                             <option value ="<%=a.getId()%>"<%=selecionadoo%>>
                                 <%=a.getNome()%>
                             </option>   
                            <%}%>
                        </select>
                        <label>Editora</label>
                        <select name="txtEditora">
                            <option value="">Selecione</option>
                            <% String selecionado;
                                for(Editora e : elista) {
                                    if(obj.getEditora().getCnpj()==e.getCnpj()){
                                        selecionado = "selecionado";
                                    }
                                    else{
                                        selecionado = "";
                                    }
                                    %>
                                    <option value="<%=e.getCnpj()%>"<%=selecionado%>> 
                                        <%=e.getNome()%>
                                    </option>
                                    <%}%>
                        </select>
                        <label> Categoria </label>
                        <selected name="txtCategoria">
                            <option value=""> Selecione</option>
                            <%
                                String sele;
                                for(Categoria c : clista){
                                    if(obj.getCategoria().getId() == c.getId()){
                                        sele="selected";
                                    }
                                    else{
                                        sele="";
                                    }
                                    %>
                                    <option value="<%=c.getId()%>"<%=sele%>>  
                                        <%=c.getNome()%>
                                    </option>
                                    <%}%>                            
                        </selected>
                        
                    </div>

                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                
                </div>
            </form>>

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
    $("#arquivo2").change(function(){
        readURL(this,"img2");
    });
    $("#arquivo3").change(function(){
        readURL(this,"img3");
    });
</script>