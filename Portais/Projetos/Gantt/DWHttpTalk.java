/*
 ************************************************
 * DWHttpTalk - Fala protocolo Http
 * Author: Fernando Patelli - Microsiga
 * Date..: 12/09/2001 
 ************************************************ */
package gantt;
import java.io.*;
import java.net.*;
/**
 * Componente permite criar uma conexão URL para falar Http com o servidor.
 * <br>Nesta versão, você pode:
 * <OL>
 * <LI>Fazer uma requisição com metodo GET para solicitar dados ao servidor.
 * <LI>Fazer uma requisição com metodo POST para enviar dados ao servidor.
 * <LI>Pegar a resposta de cada POST efetuado.
 * </OL>
 * @version 14/08/01
 * @see #openRequest
 * @author Fernando Patelli - Microsiga Software SA
 */
public class DWHttpTalk {
    
    // Attributes
    // *************************************************
    BufferedReader	m_datain;
    BufferedWriter	m_dataout;
    URL 		m_url;
    URLConnection	m_conn;
    String		m_response;
    
    // Constructors
    // *************************************************
    /**
     * Instancia um novo objeto DWHttpTalk, baseado na URL passada para conexão.<br>
     * (Voce deve passar a URL ja pronta e instanciada e não só uma String)
     * @param url - Uma instancia de java.net.URL
     */
    public DWHttpTalk(URL url) {
        m_url = url;
        m_datain = null;
        m_dataout = null;
        m_conn = null;
    }

    public DWHttpTalk(URL url, String ignoreThis) {
        m_url = url;
        m_datain = null;
        m_dataout = null;
        m_conn = null;
    }
    
    // Public Methods
    // *************************************************
    /**
     * Abre uma requisição ao servidor Http, para efetuar	um metodo: Get ou Post.
     * @param method - "GET" ou "POST"
     * @param mime - Formato MIME do conteudo a ser trabalhado. Ex: "text/html"
     * @return true se der certo.
     */
    public boolean openRequest(String method, String mime) {
        
        // Verifica os parametros
        method = (method==null ? "" : method.toUpperCase().trim());
        if( (!method.equals("GET") && !method.equals("POST")) )
            return false;
        
        // Tenta trabalhar o recurso URL
        try {
            // conecta
            m_conn = m_url.openConnection();
            //if (mime.substring(1,3).equals("App")) {
//                m_conn.setRequestProperty("Content-Type", mime);
//            }
/*             else if (!(System.getProperty("os.name").equalsIgnoreCase("Linux")))
            {
*/                m_conn.setRequestProperty("Cookie", "SESSIONID=" + mime);
/*            }*/
            // stream
            if(method.equals("POST")) {
                m_conn.setDoOutput(true);
                m_conn.setDoInput(true);
                m_dataout = new BufferedWriter(
                new OutputStreamWriter(m_conn.getOutputStream()));
            } else {
                m_conn.setDoInput(true);
                m_datain  = new BufferedReader(
                new InputStreamReader(m_conn.getInputStream()));
            }
            return true; // ok
        } catch(UnknownServiceException e) {
            System.err.println("Erro no Protocolo: "+e.getMessage());
        } catch(IOException e) {
            System.err.println("Erro de I/O: "+e.getMessage());
        }
        return false; // erro
    }
    
    /**
     * Escreve na saida de rede para o WebServer.
     * @param data - String que contém os dados a serem escritos.
     * @return Boolean, retorna true se der certo.
     */
    public boolean write(String data) {
        try {
            m_dataout.write(data.toCharArray(), 0, data.length());
        } catch(Exception e) {
            System.err.println("Erro no write() Stream(out): "+e.getMessage());
            return false; // erro
        }
        return true; // ok
    }
    
    /**
     * Le na entrada de rede a partir do WebServer.
     * @return Uma String com o que foi lido.
     */
    public String read() {
        int i;
        char[] c = new char[1024];
        String data = "";
        try {
            while(m_datain.ready()) {
                i = m_datain.read(c, 0, c.length);
                data += new String(c, 0, i);
            }
        } catch(Exception e) {
            System.err.println("Erro no read() pela Stream(out): "+e.getMessage());
            return null; // erro
        }
        return data; // ok
    }
    
    /**
     * Encerra o request no WebServer.
     * @return Boolean, retorna true se der certo.
     */
    public boolean closeRequest() {
        try {
            if(m_dataout!=null) {
                m_dataout.close();
                m_datain  = new BufferedReader(
                new InputStreamReader(m_conn.getInputStream()));
                m_response = read();
            }
            if(m_datain!=null) m_datain.close();
        } catch(Exception e) {
            System.err.println("Erro no close() das Streams(in/out): "+e.getMessage());
            return false; // erro
        }
        return true; //ok
    }
    
    /**
     * Le na entrada de rede a partir do WebServer.
     * @return Uma String com a resposta do servidor.
     */
    public String getResponse() {
        return(m_response);
    }
    
}	// Fim da definicao da classe DWHttpTalk
