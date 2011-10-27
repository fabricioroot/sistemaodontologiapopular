package annotations;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "Dente")
public class Dente implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "nome", nullable = false)
    private String nome;

    @Column(name = "posicao", nullable = true)
    private String posicao;

    @Column(name = "faceDistal", nullable = false)
    private Short faceDistal;

    @Column(name = "faceMesial", nullable = false)
    private Short faceMesial;

    @Column(name = "faceIncisal", nullable = false)
    private Short faceIncisal;

    @Column(name = "faceBucal", nullable = false)
    private Short faceBucal;

    @Column(name = "faceLingual", nullable = false)
    private Short faceLingual;

    @Column(name = "raiz", nullable = false)
    private Short raiz;

    @Lob
    @Column(name = "observacao", nullable = true)
    private String observacao;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dente", fetch = FetchType.LAZY, targetEntity = HistoricoDente.class)
    private Set<HistoricoDente> historicoDenteSet;

    @JoinColumn(name = "bocaId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = true, fetch = FetchType.LAZY, targetEntity = Boca.class)
    private Boca boca;

    public Dente() {
    }

    public Dente(Integer id) {
        this.id = id;
    }

    public Dente(Integer id, String nome, String posicao) {
        this.id = id;
        this.nome = nome;
        this.posicao = posicao;
    }

    public Dente(String nome, String posicao, Boca boca) {
        this.nome = nome;
        this.posicao = posicao;
        this.boca = boca;
        this.faceBucal = Short.parseShort("0");
        this.faceDistal = Short.parseShort("0");
        this.faceIncisal = Short.parseShort("0");
        this.faceLingual = Short.parseShort("0");
        this.faceMesial = Short.parseShort("0");
        this.raiz = Short.parseShort("0");
        this.historicoDenteSet = new HashSet<HistoricoDente>();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getPosicao() {
        return posicao;
    }

    public void setPosicao(String posicao) {
        this.posicao = posicao;
    }

    public Short getFaceBucal() {
        return faceBucal;
    }

    public void setFaceBucal(Short faceBucal) {
        this.faceBucal = faceBucal;
    }

    public Short getFaceDistal() {
        return faceDistal;
    }

    public void setFaceDistal(Short faceDistal) {
        this.faceDistal = faceDistal;
    }

    public Short getFaceIncisal() {
        return faceIncisal;
    }

    public void setFaceIncisal(Short faceIncisal) {
        this.faceIncisal = faceIncisal;
    }

    public Short getFaceLingual() {
        return faceLingual;
    }

    public void setFaceLingual(Short faceLingual) {
        this.faceLingual = faceLingual;
    }

    public Short getFaceMesial() {
        return faceMesial;
    }

    public void setFaceMesial(Short faceMesial) {
        this.faceMesial = faceMesial;
    }

    public Short getRaiz() {
        return raiz;
    }

    public void setRaiz(Short raiz) {
        this.raiz = raiz;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Set<HistoricoDente> getHistoricoDenteSet() {
        return historicoDenteSet;
    }

    public void setHistoricoDenteSet(Set<HistoricoDente> historicoDenteSet) {
        this.historicoDenteSet = historicoDenteSet;
    }

    public Boca getBoca() {
        return boca;
    }

    public void setBoca(Boca boca) {
        this.boca = boca;
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
        if (!(object instanceof Dente)) {
            return false;
        }
        Dente other = (Dente) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.Dente[id=" + id + "]";
    }

}
