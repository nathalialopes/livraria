/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author aluno
 */
@Entity
@Table(name = "compra_livro")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CompraLivro.findAll", query = "SELECT c FROM CompraLivro c"),
    @NamedQuery(name = "CompraLivro.findById", query = "SELECT c FROM CompraLivro c WHERE c.id = :id"),
    @NamedQuery(name = "CompraLivro.findByQuantidade", query = "SELECT c FROM CompraLivro c WHERE c.quantidade = :quantidade"),
    @NamedQuery(name = "CompraLivro.findByValorunitario", query = "SELECT c FROM CompraLivro c WHERE c.valorunitario = :valorunitario")})
public class CompraLivro implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "quantidade")
    private int quantidade;
    @Basic(optional = false)
    @Column(name = "valorunitario")
    private float valorunitario;
    @JoinColumn(name = "compra", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Compra compra;
    @JoinColumn(name = "livro", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Livro livro;

    public CompraLivro() {
    }

    public CompraLivro(Integer id) {
        this.id = id;
    }

    public CompraLivro(Integer id, int quantidade, float valorunitario) {
        this.id = id;
        this.quantidade = quantidade;
        this.valorunitario = valorunitario;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public float getValorunitario() {
        return valorunitario;
    }

    public void setValorunitario(float valorunitario) {
        this.valorunitario = valorunitario;
    }

    public Compra getCompra() {
        return compra;
    }

    public void setCompra(Compra compra) {
        this.compra = compra;
    }

    public Livro getLivro() {
        return livro;
    }

    public void setLivro(Livro livro) {
        this.livro = livro;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CompraLivro)) {
            return false;
        }
        CompraLivro other = (CompraLivro) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.CompraLivro[ id=" + id + " ]";
    }
    
}
