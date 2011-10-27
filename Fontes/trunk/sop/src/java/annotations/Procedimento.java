package annotations;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.directwebremoting.annotations.DataTransferObject;
import org.directwebremoting.annotations.Param;
import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import service.DwrUtil;
import service.ProcedimentoService;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "Procedimento")
@RemoteProxy
@DataTransferObject(params = @Param(name = "exclude", value = "historicoDenteSet, historicoBocaSet"))
public class Procedimento implements Serializable {
    //private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Short id;

    @Column(name = "nome", nullable = false, unique = true)
    private String nome;

    @Column(name = "descricao", nullable = false, unique = true)
    private String descricao;

    @Column(name = "simbolo", nullable = true)
    private String simbolo;

    @Column(name = "valor", nullable = false)
    private Double valor;

    @Column(name = "valorMinimo", nullable = false)
    private Double valorMinimo;

    @Column(name = "status", nullable = false)
    private char status;

    @Column(name = "tipo", nullable = false)
    private String tipo;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "procedimento", fetch = FetchType.LAZY, targetEntity = HistoricoDente.class)
    private Set<HistoricoDente> historicoDenteSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "procedimento", fetch = FetchType.LAZY, targetEntity = HistoricoBoca.class)
    private Set<HistoricoBoca> historicoBocaSet;

    @Transient
    private Collection<Procedimento> procedimentos = new ArrayList<Procedimento>();

    public Procedimento() {
    }

    public Procedimento(Short id) {
        this.id = id;
    }

    public Procedimento(Short id, String nome, String descricao, Double valor, Double valorMinimo, char status, String tipo) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.valor = valor;
        this.valorMinimo = valorMinimo;
        this.status = status;
        this.tipo = tipo;
    }

    public Short getId() {
        return id;
    }

    public void setId(Short id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getSimbolo() {
        return simbolo;
    }

    public void setSimbolo(String simbolo) {
        this.simbolo = simbolo;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }

    public Double getValorMinimo() {
        return valorMinimo;
    }

    public void setValorMinimo(Double valorMinimo) {
        this.valorMinimo = valorMinimo;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Set<HistoricoDente> getHistoricoDenteSet() {
        return historicoDenteSet;
    }

    public void setHistoricoDenteSet(Set<HistoricoDente> historicoDenteSet) {
        this.historicoDenteSet = historicoDenteSet;
    }

    public Set<HistoricoBoca> gethistoricoBocaSet() {
        return historicoBocaSet;
    }

    public void sethistoricoBocaSet(Set<HistoricoBoca> historicoBocaSet) {
        this.historicoBocaSet = historicoBocaSet;
    }

    @RemoteMethod
    public void carregarProcedimentosPDDI() {
        // Remove as opcoes do combo de procedimentos
        DwrUtil.getUtil().removeAllOptions("procedimentoId");

        Procedimento procedimento = new Procedimento();
        procedimento.setNome("Selecione");
        this.procedimentos.add(procedimento);

        // Busca no banco os procedimentos de parte dente e dente inteiro ativos
        this.procedimentos.addAll(ProcedimentoService.getProcedimentosPDDIAtivos());

        //Adicionando a lista de procedimentos a combo apropriada
        DwrUtil.getUtil().addOptions("procedimentoId", this.procedimentos, "id", "nome");
    }

    @RemoteMethod
    public void carregarProcedimentosBC() {
        // Remove as opcoes do combo de procedimentos
        DwrUtil.getUtil().removeAllOptions("procedimentoId");

        Procedimento procedimento = new Procedimento();
        procedimento.setNome("Selecione");
        this.procedimentos.add(procedimento);

        // Busca no banco os procedimentos de boca completa ativos
        this.procedimentos.addAll(ProcedimentoService.getProcedimentosBCAtivos());

        //Adicionando a lista de procedimentos a combo apropriada
        DwrUtil.getUtil().addOptions("procedimentoId", this.procedimentos, "id", "nome");
    }

    @RemoteMethod
    public void marcarValoresPDDI(String idProcedimento) {
        // Marreta!
        if (idProcedimento == null || idProcedimento.equals("null")) {
            idProcedimento = "";
        }
        if (!idProcedimento.isEmpty()) {
            // Busca no banco o procedimento
            Procedimento procedimento = ProcedimentoService.getProcedimento(Short.parseShort(idProcedimento));
            DecimalFormat decimalFormat = new DecimalFormat("0.00");

            // Marca os campos de valor
            DwrUtil.getUtil().setValue("valor", decimalFormat.format(procedimento.getValor()));
            DwrUtil.getUtil().setValue("valorProcedimento", procedimento.getValor());
            DwrUtil.getUtil().setValue("valorCobrado", procedimento.getValor());
            DwrUtil.getUtil().setValue("valorMinimo", procedimento.getValorMinimo());
            DwrUtil.getUtil().setValue("valorMinimoProcedimento", procedimento.getValorMinimo());
            DwrUtil.getUtil().setValue("tipoProcedimento", procedimento.getTipo());

            if (procedimento.getTipo().equals("DI")) {
                DwrUtil.getUtil().addFunctionCall("desabilitarCheckBoxesDente");
                DwrUtil.getUtil().setValue("checkRaiz", true);
                DwrUtil.getUtil().setStyle("raiz", "background", "url(../../imagens/faces/r-on.gif)");
                DwrUtil.getUtil().setStyle("checkRaiz", "background", "#FFDD00");
                DwrUtil.getUtil().setValue("checkFaceSuperior", true);
                DwrUtil.getUtil().setStyle("faceSuperior", "background", "url(../../imagens/faces/ced-on.gif)");
                DwrUtil.getUtil().setStyle("checkFaceSuperior", "background", "#FFDD00");
                DwrUtil.getUtil().setValue("checkFaceEsquerda", true);
                DwrUtil.getUtil().setStyle("faceEsquerda", "background", "url(../../imagens/faces/e-on.gif)");
                DwrUtil.getUtil().setStyle("checkFaceEsquerda", "background", "#FFDD00");
                DwrUtil.getUtil().setValue("checkFaceMeio", true);
                DwrUtil.getUtil().setStyle("faceMeio", "background", "#FFDD00");
                DwrUtil.getUtil().setStyle("checkFaceMeio", "background", "#FFDD00");
                DwrUtil.getUtil().setValue("checkFaceDireita", true);
                DwrUtil.getUtil().setStyle("faceDireita", "background", "url(../../imagens/faces/d-on.gif)");
                DwrUtil.getUtil().setStyle("checkFaceDireita", "background", "#FFDD00");
                DwrUtil.getUtil().setValue("checkFaceInferior", true);
                DwrUtil.getUtil().setStyle("faceInferior", "background", "url(../../imagens/faces/bed-on.gif)");
                DwrUtil.getUtil().setStyle("checkFaceInferior", "background", "#FFDD00");
            }
            else {
                DwrUtil.getUtil().addFunctionCall("habilitarCheckBoxesDente");
                DwrUtil.getUtil().setValue("checkRaiz", false);
                DwrUtil.getUtil().setStyle("raiz", "background", "url(../../imagens/faces/r-off.gif)");
                DwrUtil.getUtil().setStyle("checkRaiz", "background", "");
                DwrUtil.getUtil().setValue("checkFaceSuperior", false);
                DwrUtil.getUtil().setStyle("faceSuperior", "background", "url(../../imagens/faces/ced-off.gif)");
                DwrUtil.getUtil().setStyle("checkFaceSuperior", "background", "");
                DwrUtil.getUtil().setValue("checkFaceEsquerda", false);
                DwrUtil.getUtil().setStyle("faceEsquerda", "background", "url(../../imagens/faces/e-off.gif)");
                DwrUtil.getUtil().setStyle("checkFaceEsquerda", "background", "");
                DwrUtil.getUtil().setValue("checkFaceMeio", false);
                DwrUtil.getUtil().setStyle("faceMeio", "background", "");
                DwrUtil.getUtil().setStyle("checkFaceMeio", "background", "");
                DwrUtil.getUtil().setValue("checkFaceDireita", false);
                DwrUtil.getUtil().setStyle("faceDireita", "background", "url(../../imagens/faces/d-off.gif)");
                DwrUtil.getUtil().setStyle("checkFaceDireita", "background", "");
                DwrUtil.getUtil().setValue("checkFaceInferior", false);
                DwrUtil.getUtil().setStyle("faceInferior", "background", "url(../../imagens/faces/bed-off.gif)");
                DwrUtil.getUtil().setStyle("checkFaceInferior", "background", "");
            }
        }
        else {
            DwrUtil.getUtil().addFunctionCall("habilitarCheckBoxesDente");
            DwrUtil.getUtil().setValue("valor", "");
            DwrUtil.getUtil().setValue("valorProcedimento", "");
            DwrUtil.getUtil().setValue("valorCobrado", "");
            DwrUtil.getUtil().setValue("valorMinimo", "");
            DwrUtil.getUtil().setValue("valorMinimoProcedimento", "");
            DwrUtil.getUtil().setValue("tipoProcedimento", "");
            DwrUtil.getUtil().setValue("checkRaiz", false);
            DwrUtil.getUtil().setStyle("raiz", "background", "url(../../imagens/faces/r-off.gif)");
            DwrUtil.getUtil().setStyle("checkRaiz", "background", "");
            DwrUtil.getUtil().setValue("checkFaceSuperior", false);
            DwrUtil.getUtil().setStyle("faceSuperior", "background", "url(../../imagens/faces/ced-off.gif)");
            DwrUtil.getUtil().setStyle("checkFaceSuperior", "background", "");
            DwrUtil.getUtil().setValue("checkFaceEsquerda", false);
            DwrUtil.getUtil().setStyle("faceEsquerda", "background", "url(../../imagens/faces/e-off.gif)");
            DwrUtil.getUtil().setStyle("checkFaceEsquerda", "background", "");
            DwrUtil.getUtil().setValue("checkFaceMeio", false);
            DwrUtil.getUtil().setStyle("faceMeio", "background", "");
            DwrUtil.getUtil().setStyle("checkFaceMeio", "background", "");
            DwrUtil.getUtil().setValue("checkFaceDireita", false);
            DwrUtil.getUtil().setStyle("faceDireita", "background", "url(../../imagens/faces/d-off.gif)");
            DwrUtil.getUtil().setStyle("checkFaceDireita", "background", "");
            DwrUtil.getUtil().setValue("checkFaceInferior", false);
            DwrUtil.getUtil().setStyle("faceInferior", "background", "url(../../imagens/faces/bed-off.gif)");
            DwrUtil.getUtil().setStyle("checkFaceInferior", "background", "");
        }
    }

    @RemoteMethod
    public void marcarValoresBC(String idProcedimento) {
        // Marreta!
        if (idProcedimento == null || idProcedimento.equals("null")) {
            idProcedimento = "";
        }
        if (!idProcedimento.isEmpty()) {
            // Busca no banco o procedimento
            Procedimento procedimento = ProcedimentoService.getProcedimento(Short.parseShort(idProcedimento));
            DecimalFormat decimalFormat = new DecimalFormat("0.00");

            // Marca os campos campos de valor
            DwrUtil.getUtil().setValue("valor", decimalFormat.format(procedimento.getValor()));
            DwrUtil.getUtil().setValue("valorProcedimento", procedimento.getValor());
            DwrUtil.getUtil().setValue("valorCobrado", procedimento.getValor());
            DwrUtil.getUtil().setValue("valorMinimo", procedimento.getValorMinimo());
            DwrUtil.getUtil().setValue("valorMinimoProcedimento", procedimento.getValorMinimo());
            DwrUtil.getUtil().setValue("tipoProcedimento", procedimento.getTipo());
        }
        else {
            DwrUtil.getUtil().setValue("valor", "");
            DwrUtil.getUtil().setValue("valorProcedimento", "");
            DwrUtil.getUtil().setValue("valorCobrado", "");
            DwrUtil.getUtil().setValue("valorMinimo", "");
            DwrUtil.getUtil().setValue("valorMinimoProcedimento", "");
        }
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
        if (!(object instanceof Procedimento)) {
            return false;
        }
        Procedimento other = (Procedimento) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.Procedimento[id=" + id + "]";
    }
}