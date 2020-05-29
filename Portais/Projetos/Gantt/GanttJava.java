package gantt;
import java.awt.print.PageFormat;
import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
import java.util.*;
import java.text.*;
import java.net.*;
import pv.jfcx.*;
import pv.util.*;
import gantt.*;

public class GanttJava extends javax.swing.JApplet{
    static final long HOUR = 1000 * 60 * 60;
    static final long HOUR2 = HOUR * 2;
    static final long HOUR6 = HOUR * 6;
    static final long HOUR12 = HOUR * 12;
    static final long DAY = HOUR * 24;
    static final long MONTH = DAY * 30;
    static final long WEEK = DAY * 7; 
    static final long YEAR = MONTH * 12;
    static final long YEAR2 = 2 * YEAR;
    static final long YEAR10 = 10 * YEAR;
    
    static final String SEPARADOR = "|" ;
    static final Color EDTExecutada = new Color( 0x000000 );
    static final Color EDTPendente  = new Color( 0x696969 );
    static final Color TarExecutada = new Color( 0x0000ff );
    static final Color TarPendente  = new Color( 0x6495ed );
    
    static final Font  EDTFont  = new Font("SansSerif", Font.BOLD, 11);
    static final Font  TarFont  = new Font("SansSerif", Font.PLAIN, 11);
    
    static final int R_HORAS		= 0;
    static final int R_HORAS2		= 1;
    static final int R_HORAS6		= 2;
    static final int R_HORAS12		= 3;
    static final int R_DIA		= 4;
    static final int R_SEMANA		= 5;
    static final int R_MES		= 6;
    
    int zoomOpt	=   R_SEMANA;
    
    public pv.jfcx.JPVStaticText taskInfo    = new pv.jfcx.JPVStaticText("", false);
    public pv.jfcx.JPVStaticText taskInfoP   = new pv.jfcx.JPVStaticText("", false);
    //public pv.jfcx.JPVStaticText taskInfoR   = new pv.jfcx.JPVStaticText("", false);
    public pv.jfcx.JPVStaticText taskInfoRec = new pv.jfcx.JPVStaticText("", false);
    
    private Vector atasks 	= 	new Vector();
    private Vector aheader 	= 	new Vector();
    private Vector aDiasSemanas = new Vector();
    public ReguaGantt	regua =	new ReguaGantt();
    
    public pv.jfcx.JPVMSGantt graficoGantt;
    private int taskenumerator = 0;
    private JPanel ganttpainel;
    //--------------------
    
    public GanttJava() {
	
    }
    public void montaGantt(){
//	carregaDados();
	
	enableEvents(AWTEvent.WINDOW_EVENT_MASK | AWTEvent.MOUSE_MOTION_EVENT_MASK);
	Container pain = getContentPane();
	pain.setLayout(new BorderLayout());
	//message("teste de message");
	//Cria o toolbar
	initComponents();
	//-------------------
	// create JPVMSGantt
	graficoGantt = new pv.jfcx.JPVMSGantt(buildTree());
	graficoGantt.setEnabled(true);
	//Cria e inicializa objeto com os dados das reguas do gantt
	setDateParameters();
	//graficoGantt.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_NEVER);
	//graficoGantt.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
	//Cria e inicializa objeto com os dados das reguas do gantt
	regua.setReguaGantt(zoomOpt);
	
	//Configura os objetos do cabecalho
	setReguaParameters();
	graficoGantt.m_imagePainter = new ImageIcon(getClass().getResource("/gantt/images/topo_01.gif")) ;
	
	//graficoGantt.setHorizontalGrid(0);
	graficoGantt.setVerticalGrid(5);
	//graficoGantt.setColumnWidth(0);
	graficoGantt.setSelectionStyle(2);
	//-------------------
	// set width of tree viewport to 200
	graficoGantt.setTreeWidth(200);
	graficoGantt.setBorder(new pv.util.JPVBorder(pv.util.PVBorder.SUNKEN + 2, Color.lightGray));
	//-------------------------------
	// set dynamic headers
	graficoGantt.m_headerBar = new DynamicHeader(graficoGantt);
	
	// replace default data-bar renderers by dynamic class
	graficoGantt.m_bar = new DynamicBar(graficoGantt);
	graficoGantt.m_selectedBar = (pv.util.PVBar)graficoGantt.m_bar.clone();
	graficoGantt.m_focusBar = (pv.util.PVBar)graficoGantt.m_bar.clone();
	
	graficoGantt.setColumnWidth(20);
	
	//-------------------------------
	graficoGantt.setCorner(graficoGantt.UPPER_LEFT_CORNER, new JLabel("Tarefas"));
	//-------------------------------
	ganttpainel = new JPanel(false);
	ganttpainel.setLayout(new BorderLayout());
	ganttpainel.add(graficoGantt);
	graficoGantt.setBounds(5, 30, 780, 560);
	
	//-------------------------------
	JPanel bottomPanel = new JPanel(false);
	JPanel bottomPanelA = new JPanel(false);
	JPanel bottomPanelB = new JPanel(false);
	
	bottomPanel.setLayout(new BoxLayout(bottomPanel, BoxLayout.Y_AXIS));
	bottomPanelA.setLayout(new BoxLayout(bottomPanelA, BoxLayout.X_AXIS));
	bottomPanelB.setLayout(new BoxLayout(bottomPanelB, BoxLayout.X_AXIS));
	
	taskInfo.setForeground(new Color(0x0000ff));
	taskInfo.setAlignment(0);
	taskInfo.setBounds(10, 5, 790, 18);
	taskInfoP.setForeground(new Color(0x0000ff));
	taskInfoP.setAlignment(0);
	taskInfoP.setBounds(10, 5, 790, 18);
	taskInfoRec.setForeground(new Color(0x0000ff));
	
	taskInfoRec.setAlignment(0);
	taskInfoRec.setBounds(10, 5, 790, 18);
	
	bottomPanel.add(taskInfo);
	pv.jfcx.JPVStaticText st1 = new pv.jfcx.JPVStaticText("  Previsto   : ", false);
	st1.setAlignment(0);
	bottomPanelA.add(st1);
	bottomPanelA.add(taskInfoP);
	pv.jfcx.JPVStaticText st2 = new pv.jfcx.JPVStaticText("  Recursos   : ", false);
	st2.setAlignment(0);
	bottomPanelB.add(st2);
	bottomPanelB.add(taskInfoRec);
	
	bottomPanel.add(bottomPanelA);
	bottomPanel.add(bottomPanelB);
	
	pain.add(toppainel,BorderLayout.NORTH);
	pain.add(ganttpainel,BorderLayout.CENTER);
	pain.add(bottomPanel,BorderLayout.SOUTH);
	
	this.setBounds(5, 5, 795, 580);
	this.setVisible(true);
	
	graficoGantt.getTree().setPlusMinus(1);
	
	graficoGantt.getViewport().getView().addMouseListener(new java.awt.event.MouseAdapter() {
	    public void mouseClicked(java.awt.event.MouseEvent evt) {
		clickPerformed(evt);
	    }});
	    
	    graficoGantt.getViewport().getView().addMouseMotionListener(new java.awt.event.MouseMotionAdapter() {
		public void processMouseMotionEvent(java.awt.event.MouseEvent evt) {
		    String type = null;
		    switch (evt.getID()) {
			case MouseEvent.MOUSE_PRESSED:
			    type = "MOUSE_PRESSED";
			    break;
			case MouseEvent.MOUSE_RELEASED:
			    type = "MOUSE_RELEASED";
			    break;
			case MouseEvent.MOUSE_CLICKED:
			    type = "MOUSE_CLICKED";
			    break;
			case MouseEvent.MOUSE_ENTERED:
			    type = "MOUSE_ENTERED";
			    break;
			case MouseEvent.MOUSE_EXITED:
			    type = "MOUSE_EXITED";
			    break;
		    }
		    //message(type);
		}});
		
		graficoGantt.getTree().addMouseListener(new java.awt.event.MouseAdapter() {
		    public void mouseClicked(java.awt.event.MouseEvent evt) {
			clickPerformed(evt);
		    }});
		    
		    graficoGantt.getTree().addMouseMotionListener(new java.awt.event.MouseMotionAdapter() {
			public void processMouseMotionEvent(java.awt.event.MouseEvent evt) {
			    String type = null;
			    switch (evt.getID()) {
				case MouseEvent.MOUSE_PRESSED:
				    type = "MOUSE_PRESSED";
				    break;
				case MouseEvent.MOUSE_RELEASED:
				    type = "MOUSE_RELEASED";
				    break;
				case MouseEvent.MOUSE_CLICKED:
				    type = "MOUSE_CLICKED";
				    break;
				case MouseEvent.MOUSE_ENTERED:
				    type = "MOUSE_ENTERED";
				    break;
				case MouseEvent.MOUSE_EXITED:
				    type = "MOUSE_EXITED";
				    break;
			    }
			    //message(type);
			}});
			graficoGantt.addKeyListener( new KeyListener(){
			    public void keyPressed(java.awt.event.KeyEvent evt) {
				setas(evt);
			    }
			    public void keyReleased(java.awt.event.KeyEvent evt) {
				setas(evt);
			    }
			    public void keyTyped(java.awt.event.KeyEvent evt) {
				setas(evt);
			    }
			});
	/*
	graficoGantt.getTree().addActionListener(new java.awt.event.ActionListener() {
	    public void ActionPerformed(java.awt.event.ActionListener evt) {
		 clickPerformed(evt);
	}});*/
    }
    
/*
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Tipo      ³ Classe   ³ Autor ³ Bruno Sobieski        ³ Data ³ 28-10-2002 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Definicao da clase DiaColuna                                 ³±±
±±³          ³ (dias e a coluna de inicio da semana)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                     ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
 */
    class DiaColuna   extends Object{
	public short dia = 0;
	public void DiaColuna() {
	}
    }
    
/*
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Tipo      ³ Classe   ³ Autor ³ Bruno Sobieski        ³ Data ³ 28-10-2002 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Definicao da classe ReguaGantt                               ³±±
±±³          ³ (Classe com as propriedades da regua (intervalos do gantt) ) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                     ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
 */
    class ReguaGantt extends Object{
	
	public static final int R_HORAS	    = 0;
	public static final int R_HORAS2    = 1;
	public static final int R_HORAS6    = 2;
	public static final int R_HORAS12   = 3;
	public static final int R_DIA	    = 4;
	public static final int R_SEMANA    = 5;
	public static final int R_MES	    = 6;
	public static final int MINIMUM	    = 0;
	public static final int MAXIMUM	    = 6;
	
	public int     possemana    =	-1;
	public int     posbase	    =	0;
	public long    range_minimum=	0;
	public long    range_maximum=	0;
	public String  toolTip	    =	"";
	public int[]   height	    =	{17,17,14,14};
	public long[]   units	    =	{0,DAY,MONTH,YEAR};
	public String[] zoomText    =	{"","","",""};
	public SimpleDateFormat[] format=   {null,null,null,null};
	
	public ReguaGantt(){
	}
	private void initPad(){
	    possemana = -1;
	    units[0]	= 0;
	    units[1]	= DAY;
	    units[2]	= MONTH;
	    units[3]	= YEAR;
	    height[0]	= 17;
	    height[1]	= 17;
	    height[2]	= 14;
	    height[3]	= 14;
	    zoomText[0]	= "";
	    zoomText[1]	= "Dias   ";
	    zoomText[2]	= "Meses  ";
	    zoomText[3]	= "Anos   ";
	    range_minimum = 2 * DAY;
	    posbase = 0;
	}
	public void setReguaGantt(int opcao){
	    this.initPad();
	    GregorianCalendar cal= new GregorianCalendar();
	    cal.set(Calendar.MINUTE,0);
	    cal.set(Calendar.SECOND,0);
	    cal.set(Calendar.MILLISECOND,0);
	    switch(opcao) {
		case R_HORAS:
		    range_minimum   = 2 * DAY;
		    units[0]	    = HOUR;
		    zoomText[0]	    = "Horas   ";
		    format[0]	    =	new SimpleDateFormat("H");
		    format[1]	    =	new SimpleDateFormat("d");
		    format[2]	    =	new SimpleDateFormat("MMMM");
		    format[3]	    =	new SimpleDateFormat("yyyy");
		    toolTip	    = "horas, dias, meses e anos";
		    break;
		case R_HORAS2:
		    range_minimum = 2 * DAY;
		    units[0]	=	HOUR2;
		    zoomText[0]	    = "2 Horas   ";
		    format[0]	=	new SimpleDateFormat("H");
		    format[1]	=	new SimpleDateFormat("d");
		    format[2]	=	new SimpleDateFormat("MMMM");
		    format[3]	=	new SimpleDateFormat("yyyy");
		    toolTip		= "duas horas, dias, meses e anos";
		    break;
		case R_HORAS6:
		    range_minimum = 2 * DAY;
		    units[0]	 = HOUR6;
		    zoomText[0]	    = "6 Horas ";
		    format[0]	=	new SimpleDateFormat("H");
		    format[1]	=	new SimpleDateFormat("d");
		    format[2]	=	new SimpleDateFormat("MMMM");
		    format[3]	=	new SimpleDateFormat("yyyy");
		    toolTip		= "6 horas, dias, meses e anos";
		    
		    break;
		case R_HORAS12:
		    range_minimum = 4 * DAY;
		    units[0]	 = HOUR12;
		    zoomText[0]	    = "12 Horas ";
		    format[0]	=	new SimpleDateFormat("H");
		    format[1]	=	new SimpleDateFormat("d");
		    format[2]	=	new SimpleDateFormat("MMMM");
		    format[3]	=	new SimpleDateFormat("yyyy");
		    toolTip		= "12 horas, dias, meses e anos";
		    break;
		case R_DIA:
		    posbase = 1;
		    range_minimum = 8 * DAY;
		    height[0] = 0;
		    units[0]	 = DAY;
		    units[1]	 = DAY;
		    units[2]	 = MONTH;
		    units[3]	 = YEAR;
		    format[0]	=	null;
		    format[1]	=	new SimpleDateFormat("d");
		    format[2]	=	new SimpleDateFormat("MMMM");
		    format[3]	=	new SimpleDateFormat("yyyy");
		    toolTip		= "dias, meses e anos";
		    break;
		case R_SEMANA:
		    posbase = 1;
		    range_minimum = 11 * MONTH;
		    height[0]	= 0;
		    zoomText[1]	    = "Semanas";
		    units[0]	 = WEEK;
		    units[1]	 = WEEK;
		    units[2]	 = MONTH;
		    units[3]	 = YEAR;
		    format[0]	=null;
		    format[1]	=null;
		    format[2]	=new SimpleDateFormat("MMMM");
		    format[3]	=new SimpleDateFormat("yyyy");
		    possemana = 1;
		    toolTip		= "semanas, meses e anos";
		    break;
		case R_MES:
		    posbase = 2;
		    range_minimum = 4 * YEAR;
		    height[0]	 = 0;
		    height[1]	 = 0;
		    zoomText[1]	    = "";
		    units[0]	 = MONTH;
		    units[1]	 = MONTH;
		    units[2]	 = MONTH;
		    units[3]	 = YEAR;
		    format[0] =null;
		    format[1] =null;
		    format[2] =new SimpleDateFormat("MM");
		    format[3] =new SimpleDateFormat("yyyy");
		    toolTip = "meses e anos";
		    break;
	    }
	}
    }
    class DynamicBar extends pv.util.PVBar {
	pv.jfcx.JPVGantt m_gant;
	//---------------
	// save reference to gantt
	public DynamicBar(pv.jfcx.JPVGantt gant) {
	    // gray 1 pixel wide border
	    super(null, Color.gray, null, null, pv.util.PVBorder.PLANE + 1);
	    m_gant = gant;
	}
	//---------------
	// Build text using indexes of currently painted bar.
	public String getText() {
	    //---------------
	    // Get reference to a node where bar belongs.
	    pv.jfcx.JPVGanttNode node = (pv.jfcx.JPVGanttNode)m_gant.getTree().nodeAt(m_gant.unpack(m_gant.m_packedID, true));
	    String cDado	=    "";
	    if(node != null){
		int nodePos = Integer.parseInt(node.getKey().toString());
		Vector atsktmp = strtovec( atasks.elementAt(nodePos).toString(),SEPARADOR,false) ;
		;
	    }
	    //---------------
	    // Get reference to a node where bar belongs.
	    return cDado ;
	}
    }
    
    class DynamicHeader extends pv.util.PVBar {
	pv.jfcx.JPVMSGantt m_gant;
	//---------------
	// save reference to gantt
	public DynamicHeader(pv.jfcx.JPVMSGantt gant) {
	    super(null, null, null, null, 11);
	    m_gant = gant;
	}
	//---------------
	// Modify text for columns in 3rd headers.
	// Overriding this method (and any other "get..") has the most priority
	// for column-bar-appearance and it would replace default strings (formats if any).
	public String getText() {
	    String cret = "";
	    //---------------
	    // graficoGantt.setUnitsOfHeadersAt(WEEK, pv.jfcx.JPVMSGantt.HEADER3)
	    //---------------
	    // Since the width of a column in 3rd headers is equal to 1 week, -
	    if(m_gant.m_headerID == regua.possemana){
		// calculate index of column (from the left)
		long leftEdge = m_gant.m_columnValue - m_gant.getStartValue();
		int ind = 0;
//		if (! (leftEdge == 0) ) {
		ind = (int)(leftEdge / WEEK);
//		}
		DiaColuna d = (DiaColuna)aDiasSemanas.elementAt(ind);
		cret = Short.toString(d.dia);
		return cret;
	    }else{
		return super.getText();
	    }
	}
    }
    //----------------------------
    // build tree with nodes fill by data
    pv.jfcx.PVNode buildTree() {
	Object[] adados = atasks.toArray();
	Vector atsktmp= new Vector();
	taskenumerator = 0;
	pv.jfcx.JPVGanttNode	root= new pv.jfcx.JPVGanttNode();
	if (adados.length>0){
	    atsktmp	= strtovec( adados[taskenumerator].toString() , SEPARADOR , false) ;
	    root = dayNode(atsktmp);
	    root.setFont(EDTFont);
	    addNode( adados,root ,"001");
	}
	return root;
    }
    //Funcao recursiva para adicionar nodos
    void addNode(Object[] adados,pv.jfcx.JPVGanttNode father,String cLevelAnt ) {
	Vector atsktmp= new Vector();
	Vector atsktmpProx= new Vector();
	pv.jfcx.JPVGanttNode	nodoRet= new pv.jfcx.JPVGanttNode();
	boolean lowerLevel = true;
	while (taskenumerator +1 < adados.length && lowerLevel) {
	    taskenumerator++;
	    atsktmp	= strtovec( adados[taskenumerator].toString() , SEPARADOR , false) ;
	    //So incluir tarefas deste nivel o de nivel maior (embaixo deste)
	    if  (atsktmp.get(aheader.indexOf("LEVEL")).toString().compareTo(cLevelAnt) > 0 ) {
		//VErifricar se é uma EDT
		boolean isEDT = atsktmp.get(aheader.indexOf("TASKTYPE")).toString().trim().compareTo("1")!=0;
		//Criar o nodo no Gantt
		nodoRet = dayNode( atsktmp	);
		
		if (isEDT){nodoRet.setFont(EDTFont);}else{nodoRet.setFont(TarFont);}
		//Se tiver mais elementos e o proximo elemento for de nivel maior,
		//chamar recursivamente para preeencher os filhos do atual
		if ( isEDT && (taskenumerator+1) < adados.length ) {
		    atsktmpProx	= strtovec( adados[taskenumerator+1].toString()  , SEPARADOR , false) ;
		    boolean nextIsChild = atsktmpProx.get(aheader.indexOf("LEVEL")).toString().compareTo(atsktmp.get(aheader.indexOf("LEVEL")).toString()) > 0;
		    //Se oproximo for filho do atual, adiciona os filhos recursivamnente
		    if (nextIsChild) {
			addNode(adados,nodoRet,atsktmp.get(aheader.indexOf("LEVEL")).toString());
		    }
		}
		//Adiciona o nodo criado ao pai
		father.add(nodoRet);
	    } else {
		//Se o nivel da tarefa for menor, mudar o enumerator para que o item seja avaliado novamente
		//no nivelk anterior
		lowerLevel	=	false;
		taskenumerator--;//avaliar novamente no nivel anterior
	    }
	}
	return;
    }
    //----------------------------
    // Cria um nodo no tree do Gantt
    pv.jfcx.JPVGanttNode dayNode(Vector atask ) {
	
	String text = atask.get(aheader.indexOf("TASKDESCRIPTION")).toString();
	boolean isEDT = atask.get(aheader.indexOf("TASKTYPE")).toString().trim().compareTo("1")!=0;
	Vector data = new Vector();
	Object appearance = null;
	
	String cDataIni = 	atask.get(aheader.indexOf("ESTIMATEDINITIALDATE")).toString();
	String cDataFim = 	atask.get(aheader.indexOf("ESTIMATEDFINALDATE")).toString();
	String cHoraIni = 	atask.get(aheader.indexOf("ESTIMATEDINITIALHOUR")).toString();
	String cHoraFim = 	atask.get(aheader.indexOf("ESTIMATEDFINALHOUR")).toString();
	
	String cpercent= atask.get(aheader.indexOf("POC")).toString().trim();
	float percent = Float.parseFloat(cpercent.substring(0,cpercent.indexOf('%')));
	
//A data será dividida em duas, a primeira até o %finalizado e a segunda deste até o fim.
//ISto é para poder representar o avanço da tarefa.
	if ( percent == 0 || percent == 100) {
	    //Setar data inicial
	    data.addElement(stringToCal(cDataIni,cHoraIni));
	    //Setar data final
	    data.addElement(stringToCal(cDataFim,cHoraFim));
	    // create various styles of apperances for data (Color, arrays of Color, Vectors of Color)
	    
	    //Se está 100% utilizo uma cor escura
	    if (percent==100) {
		if (!isEDT)
		    appearance = new Object[]{TarExecutada};
		else
		    appearance = new Object[]{EDTExecutada};
	    } else{
		if (!isEDT)
		    appearance = new Object[]{TarPendente};
		else
		    appearance = new Object[]{EDTPendente};
	    }
	} else {
	    GregorianCalendar calIni= stringToCal(cDataIni,cHoraIni);
	    GregorianCalendar calFim1= (GregorianCalendar)calIni.clone();
	    GregorianCalendar calIni2= new GregorianCalendar();
	    GregorianCalendar calFim= stringToCal(cDataFim,cHoraFim);
	    long iniDate = (calIni.get(Calendar.YEAR)*YEAR + (calIni.get(Calendar.MONTH)+1)*MONTH +(int)(calIni.get(Calendar.DAY_OF_MONTH))*DAY);
	    long finDate = (calFim.get(Calendar.YEAR)*YEAR + (calFim.get(Calendar.MONTH)+1)*MONTH +(int)(calFim.get(Calendar.DAY_OF_MONTH))*DAY);
	    long range	= (long)((finDate-iniDate)*(percent/100));
	    //Setar data inicial 1
	    data.addElement(calIni);
	    //Setar data final 1
	    calFim1.add(Calendar.MINUTE,(int)(range*60/HOUR));
	    data.addElement(calFim1);
	    //Setar data inicial 2
	    calIni2 = (GregorianCalendar)calFim1.clone();
	    calIni2.add(Calendar.MILLISECOND,1);
	    data.addElement(calIni2);
	    //Setar data final 2
	    data.addElement(calFim);
	    if (!isEDT)
		appearance = new Object[]{TarExecutada,TarPendente};
	    else {
		appearance = new Object[]{EDTExecutada,EDTPendente};
	    }
	}
	//-------------------
	// create node with data and appearance
	int key = taskenumerator;
	pv.jfcx.JPVGanttNode nodeRet = new pv.jfcx.JPVGanttNode(text, data, appearance,Integer.toString(key));
	String cBitMap	=  "/gantt/images/"+atask.get(aheader.indexOf("BITMAP")).toString().trim().toLowerCase()+".gif";
        nodeRet.setImageAt(new javax.swing.ImageIcon(this.getClass().getResource(cBitMap)),0);
        return nodeRet;
    }
    
    void setDateParameters(){
	Calendar calIni = getStartDate();
	Calendar calFim = getFinishDate();
	calIni.set(Calendar.HOUR_OF_DAY,0);
	calIni.set(Calendar.MINUTE,0);
	calIni.set(Calendar.SECOND,0);
	calIni.set(Calendar.MILLISECOND,0);
	int ndias = 0;
	//Vamos iniciar o calendario sempre em uma segunda feira
	//para que o calendario semanal sempre comece em 2da
	while (calIni.get(Calendar.DAY_OF_WEEK) != Calendar.MONDAY) {
	    calIni.add(Calendar.DAY_OF_MONTH,-1);
	    ndias++;
	}
	
	long iniDate	= (calIni.get(Calendar.YEAR)*YEAR + (calIni.get(Calendar.MONTH)+1)*MONTH +(int)(calIni.get(Calendar.DAY_OF_MONTH))*DAY);
	long finDate	= (calFim.get(Calendar.YEAR)*YEAR + (calFim.get(Calendar.MONTH)+1)*MONTH +(int)(calFim.get(Calendar.DAY_OF_MONTH)+(ndias*2))*DAY);
	long range	= finDate-iniDate;
	regua.range_maximum = range;
	
	if (range < regua.range_minimum)
	{    range=regua.range_minimum;
	}
	graficoGantt.setStartObject(calIni);
	graficoGantt.setRange(range);
	
	Calendar calIni2 = (Calendar)calIni.clone();
	//4 Anos e o minimo maior de todos, por isto precisso garantir que tenha semanas
	//cadastradas para cubrir este minimo e o range total;
	if (regua.range_maximum < (4*YEAR) ) {
	    calFim	= (Calendar)calIni.clone();
	    calFim.add(Calendar.YEAR,4);
	}
	//Procura todas as posicoes das próximas segundas do periodo
	while ( calIni2.before(calFim) ) {
	    DiaColuna d = new DiaColuna();
	    d.dia = (short)calIni2.get(Calendar.DAY_OF_MONTH);
	    aDiasSemanas.add(d);
	    calIni2.add(Calendar.DAY_OF_MONTH,7);
	}
    }
    
//Le o primeiro registro e retorna a data inicial do projeto
    Calendar getStartDate(){
	GregorianCalendar 	cal = new GregorianCalendar();
	Object[] adados = atasks.toArray();
	Vector atask= new Vector();
	atask  = strtovec( adados[0].toString() , SEPARADOR , false) ;
	String cDataIni = 	atask.get(aheader.indexOf("ESTIMATEDINITIALDATE")).toString();
	String cHoraIni = 	atask.get(aheader.indexOf("ESTIMATEDINITIALHOUR")).toString();
	try{
	    cal = stringToCal(cDataIni,cHoraIni);
	} catch (Exception e){
	    returnErr(e.getMessage(),"Erro");
	}
	return cal;
	
    }
//Le o primeiro registro e retorna a data final	do projeto
    Calendar getFinishDate(){
	GregorianCalendar 	cal = new GregorianCalendar();
	Object[] adados = atasks.toArray();
	Vector atask= new Vector();
	atask  = strtovec( adados[0].toString() , SEPARADOR , false) ;
	String cDataFim = 	atask.get(aheader.indexOf("ESTIMATEDFINALDATE")).toString();
	String cHoraFim = 	atask.get(aheader.indexOf("ESTIMATEDFINALHOUR")).toString();
	try{
	    cal = stringToCal(cDataFim,cHoraFim);
	} catch (Exception e){
	    returnErr(e.getMessage(),"Erro");
	}
	return cal;
	
    }
    
    GregorianCalendar stringToCal(String cData, String cHora){
	GregorianCalendar cal= new GregorianCalendar();
	if (cData.trim().length() > 0 ){
	    cal.set(Calendar.YEAR ,Integer.parseInt(cData.substring(0,4)));
	    cal.set(Calendar.MONTH, Integer.parseInt(cData.substring(4,6))-1);
	    cal.set(Calendar.DAY_OF_MONTH,Integer.parseInt(cData.substring(6,8)));
	    cal.set(Calendar.HOUR_OF_DAY,Integer.parseInt(cHora.substring(0,2)));
	    cal.set(Calendar.MINUTE,Integer.parseInt(cHora.substring(3,5)));
	}
	return cal;
    }
    void setReguaParameters(){
	
	
	graficoGantt.setHeightOfHeadersAt(regua.height[0], pv.jfcx.JPVMSGantt.HEADER1);
	graficoGantt.setHeightOfHeadersAt(regua.height[1], pv.jfcx.JPVMSGantt.HEADER2);
	graficoGantt.setHeightOfHeadersAt(regua.height[2], pv.jfcx.JPVMSGantt.HEADER3);
	graficoGantt.setHeightOfHeadersAt(regua.height[3], pv.jfcx.JPVMSGantt.HEADER4);
	
	graficoGantt.setUnitsOfHeadersAt(regua.units[0], pv.jfcx.JPVMSGantt.HEADER1);
	graficoGantt.setUnitsOfHeadersAt(regua.units[1], pv.jfcx.JPVMSGantt.HEADER2);
	graficoGantt.setUnitsOfHeadersAt(regua.units[2], pv.jfcx.JPVMSGantt.HEADER3);
	graficoGantt.setUnitsOfHeadersAt(regua.units[3], pv.jfcx.JPVMSGantt.HEADER4);
	
	graficoGantt.setFormatOfHeadersAt(regua.format[0], pv.jfcx.JPVMSGantt.HEADER1);
	graficoGantt.setFormatOfHeadersAt(regua.format[1], pv.jfcx.JPVMSGantt.HEADER2);
	graficoGantt.setFormatOfHeadersAt(regua.format[2], pv.jfcx.JPVMSGantt.HEADER3);
	graficoGantt.setFormatOfHeadersAt(regua.format[3], pv.jfcx.JPVMSGantt.HEADER4);
	
	graficoGantt.setToolTipText("Escala em "+regua.toolTip);
	if (regua.range_maximum > regua.range_minimum) {
	    graficoGantt.setRange(regua.range_maximum); } else {
	    graficoGantt.setRange(regua.range_minimum );
	    }
	reBuildZoomOpt();
    }
    //-------------------
    // Atualiza o ZOOM da regua
    void updateZoom(boolean up) {
	int novoZoom	=   zoomOpt;
	if (up) novoZoom= zoomOpt-1; else novoZoom= zoomOpt+1;
	if ( regua.MINIMUM <= novoZoom  && novoZoom <= regua.MAXIMUM) {
	    zoomOpt =	novoZoom;
	    //Cria e inicializa objeto com os dados das reguas do gantt
	    regua.setReguaGantt(zoomOpt);
	    //Seta as reguas no Gantt
	    setReguaParameters();
	    graficoGantt.refresh();
	    graficoGantt.repaint();
	}
    }
    //-------------------
    // Cria o objeto "Seletor de ZOOM"
    void reBuildZoomOpt() {
	//--------------
	scrollSizeCombo.removeAllItems();
	if (graficoGantt.getHeightOfHeadersAt( pv.jfcx.JPVMSGantt.HEADER1) >0)
	    scrollSizeCombo.addItem((Object)regua.zoomText[0]);
	
	if (graficoGantt.getHeightOfHeadersAt( pv.jfcx.JPVMSGantt.HEADER2) >0)
	    scrollSizeCombo.addItem((Object)regua.zoomText[1]);
	
	if (graficoGantt.getHeightOfHeadersAt( pv.jfcx.JPVMSGantt.HEADER3) >0)
	    scrollSizeCombo.addItem((Object)regua.zoomText[2]);
	
	if (graficoGantt.getHeightOfHeadersAt( pv.jfcx.JPVMSGantt.HEADER4) >0)
	    scrollSizeCombo.addItem((Object)regua.zoomText[3]);
	
	scrollSizeCombo.setSelectedIndex(0);
    }
    
    //--------------
    // process action events
    /*public void zoomSelectionPerformed(ActionEvent e) {
	if(e.getID() == pv.jfcx.JPVChoice.EDIT_UPDATED && (e.getSource() instanceof pv.jfcx.JPVChoice))
	    updateZoom(((pv.jfcx.JPVChoice)e.getSource()).getSelectedIndex());
    }*/
    //-------------------------
    // close application
    protected void processWindowEvent(WindowEvent e) {
	if(e.getID() == WindowEvent.WINDOW_CLOSING) System.exit(0); }
    //--------------------
    private void returnErr(String cMsg, String cTitErro){
	String sURL = this.getCodeBase()+"W_PWSP001.apw?cErro="+cMsg+"&cTitErro="+cTitErro;
	try{
	    URL dwurl = new URL(sURL);
	    this.getAppletContext().showDocument(dwurl,"_self");
	}catch(Exception e2){}
	
    }
    public  Vector strtovec(String sDados, String sDelim, boolean lVer) {
	
	String sDado;
	sDados.trim();
	StringTokenizer stDados = new StringTokenizer(sDados, sDelim);
	Vector vDados = new Vector();
	while(stDados.hasMoreTokens()) {
	    sDado = stDados.nextToken();
	    vDados.addElement(sDado);
	    if(lVer)
		message("Len -> "+sDado.length()+" Dado -> " + sDado);
	}
	return vDados;
    }
    public  void carregaDados() {
	String sHeader = "TASKTYPE#PROJECTCODE#TASKCODE#TASKDESCRIPTION#TIMEDURATION#ESTIMATEDINITIALDATE#ESTIMATEDFINALDATE#ESTIMATEDINITIALHOUR#ESTIMATEDFINALHOUR#EXECUTIONINITIALDATE#EXECUTIONFINALDATE#POC#CPM#LEVEL#RESOURCES#DBRECORD";
	aheader = strtovec( sHeader  , "#", false);
//		  String tsk = "2_|_NOVO		  _|_NOVO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_001_|_2_|_\n1_|_1			  _|_TESTE SUBCOMPOSICAO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_002_|_1_|_\n 2_|_2			  _|_EDT 2_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_002_|_3_|_\n2_|_2.1			_|_NOVO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_003_|_4_|_\ns1_|_2.1.1		 _|_TESTE SUBCOMPOSICAO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_2_|_\n2_|_3			  _|_EDT 2_|_	0.00_|_  /  /	 _|_  /  /	 _|_	  _|_	  _|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_5_|_\n";
	//			 String tsk = "2_|_NOVO		  _|_NOVO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_001_|_2_|_\n1_|_1			  _|_TESTE SUBCOMPOSICAO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_002_|_1_|_\n 2_|_2			  _|_EDT 2_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_001_|_3_|_\n2_|_2.1			_|_NOVO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_001_|_4_|_\ns1_|_2.1.1		 _|_TESTE SUBCOMPOSICAO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_001_|_2_|_\n2_|_3			  _|_EDT 2_|_	0.00_|_  /  /	 _|_  /  /	 _|_	  _|_	  _|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_001_|_5_|_\n";
//	String tsk = "2_|_NOVO		  _|_Projeto de teste_|_	0.00_|_29/04/2005_|_28/09/2007_|_18:00_|_18:00_|_03/11/2005_|_  /  /	 _|_  0.00%_|_0_|_001_|_2_|_ \n1_|_1			  _|_TESTE SUBCOMPOSICAO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_002_|_1_|_ \n1_|_2			  _|_TESTE SUBCOMPOSICAO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_002_|_26_|_ \n1_|_ERR000000029_|_TESTE SUBCOMPOSICAO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_002_|_27_|_ \n2_|_2			  _|_EDT 2_|_	0.00_|_31/10/2005_|_03/11/2005_|_08:00_|_09:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_002_|_3_|_ \n2_|_2.1			_|_NOVO_|_	0.00_|_31/10/2005_|_03/11/2005_|_08:00_|_09:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_003_|_4_|_ \n1_|_2.1.1		 _|_TESTE SUBCOMPOSICAO_|_	0.00_|_31/10/2005_|_31/10/2005_|_08:00_|_08:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_2_|_ \n1_|_3			  _|_EDT 2_|_	0.00_|_03/11/2005_|_03/11/2005_|_ 09:00_|_09:00_|_  /  /	 _|_  /  /	 _|_  0.00%		  _|_0_|_004_|_3_|_ \n2_|_ERR000000001_|_Gerenciamento do Projeto Protheus 9_|_	0.00_|_29/04/2005_|_28/09/2007_|_18:00_|_18:00_|_03/11/2005_|_  /  /	 _|_  0.00%_|_0_|_002_|_6_|_ \n2_|_ERR000000002_|_Iniciação_|_	0.00_|_02/05/2005_|_02/05/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_  50.00%_|_0_|_003_|_7_|_ \n1_|_ERR000000003_|_Elaborar Termo de Abertura do Projeto_|_	7.00_|_02/05/2005_|_02/05/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_4_|_ \n1_|_ERR000000004_|_Kick-off meeting do projeto_|_	7.00_|_02/05/2005_|_02/05/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_50.00%_|_0_|_004_|_5_|_ \n2_|_ERR000000005_|_Planejamento_|_	0.00_|_02/05/2005_|_31/10/2005_|_09:00_|_19:00_|_03/11/2005_|_  /  /	 _|_  0.00%_|_0_|_003_|_8_|_ \n1_|_ERR000000006_|_Preparar Plano de Gerenciamento de Escopo_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_0.00%_|_0_|_004_|_6_|_ \n1_|_ERR000000 007_|_Preparar Declaração de Escopo_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_7_|_ \n1_|_ERR000000008_|_Preparar Plano de Gereciamento de Custo_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_8_|_ \n1_|_ERR000000009_|_Preparar Plano de Gereciamento de Qualidade_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_9_|_ \n1_|_ERR000000010_|_Preparar Plano de Gereciamento de RH_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_10_|_ \n1_|_ERR000000011_|_Preparar Plano de Gereciamento de Comunicações_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_11_|_ \n1_|_ERR000000012_|_Preparar Plano de Gerenciamento de Tempo_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_12_|_ \n1_|_ ERR000000013_|_Criar WBS_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_13_|_ \n1_|_ERR000000014_|_Definir Atividades_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_14_|_ \n1_|_ERR000000015_|_Sequenciar atividades_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_15_|_ \n1_|_ERR000000016_|_Estimar duração das atividades_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_16_|_ \n1_|_ERR000000017_|_Preparar Cronograma Geral_|_ 343.00_|_02/05/2005_|_01/07/2005_|_09:00_|_19:00_|_03/11/2005_|_03/11/2005_|_100.00%_|_0_|_004_|_17_|_ \n1_|_ERR000000018_|_Preparar Declarações de Trabalho de Parceiros_|_1031.00_|_02/05/2005_|_31/10/2005_|_09:00_|_19:00_|_03/11/2005_|_  /  /	 _|_ 20.00%_|_0_|_004_|_18_|_ \n2_|_ERR000000019_|_Execução_|_	0.00_|_29/04/2005_|_28/09/2007_|_18:00_|_18:00_| _  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_003_|_9_|_ \n1_|_ERR000000020_|_Gerenciar e dirigir Execução do Projeto_|_5024.00_|_29/04/2005_|_28/09/2007_|_18:00_|_18:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_19_|_ \n2_|_ERR000000021_|_Controle_|_	0.00_|_29/04/2005_|_28/09/2007_|_18:00_|_18:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_003_|_10_|_ \n1_|_ERR000000022_|_Realizar Reunião Acompanhamento Projeto_|_5024.00_|_29/04/2005_|_28/09/2007_|_18:00_|_18:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_20_|_ \n1_|_ERR000000023_|_Realizar Reunião CCB_|_5024.00_|_29/04/2005_|_28/09/2007_|_18:00_|_18:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_21_|_ \n1_|_ERR000000024_|_Realizar Reunião Avaliação de Parceiros_|_5024.00_|_29/04/2005_|_28/09/2007_|_18:00_|_18:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_22_|_ \n1_|_ERR000000025_|_Realizar Reunião Avaliação Planos de Projeto_|_5024.00_|_29/04/2005_|_28/09/2007_|_18:00_|_18:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_23_|_ \n2_|_ERR0 00000026_|_Encerramento_|_	0.00_|_28/02/2007_|_30/03/2007_|_18:00_|_18:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_003_|_11_|_ \n1_|_ERR000000027_|_Revisar e encerrar a pasta do projeto_|_ 176.00_|_28/02/2007_|_30/03/2007_|_18:00_|_18:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_24_|_ \n1_|_ERR000000028_|_Realizar reunião de encerramento do projeto_|_ 176.00_|_28/02/2007_|_30/03/2007_|_18:00_|_18:00_|_  /  /	 _|_  /  /	 _|_  0.00%_|_0_|_004_|_25_|_\n";		  atasks = strtovec( tsk  , "\n", false);
	String tsk = "qqq2_|_2222222222_|_2222222222  _|_PROJETO REVISAO 01 - COM ESTRUTURA_|_ 600.00_|_20050817_|_20051117_|_08:00_|_15:00_|_20050818_|_        _|_ 39.07%_|_0_|_001_|__|_33_|_ \n2_|_2222222222_|_1           _|_EDT 1_|_  20.00_|_20051027_|_20051031_|_16:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_002_|__|_31_|_ \n1_|_2222222222_|_11          _|_EDT 1 - TAREFA 1_|_  10.00_|_20051028_|_20051031_|_17:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_003_|__|_13_|_ \n1_|_2222222222_|_12          _|_EDT 1 - TAREFA 2_|_  10.00_|_20051028_|_20051031_|_17:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_003_|__|_14_|_ \n2_|_2222222222_|_13          _|_EDT 1 - NIVEL 2_|_  20.00_|_20051027_|_20051031_|_16:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_003_|__|_36_|_ \n1_|_2222222222_|_131         _|_EDT 1 - NIVEL 2 - TAREFA 1_|_  20.00_|_20051027_|_20051031_|_16:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_004_|__|_21_|_ \n1_|_2222222222_|_132         _|_EDT 1 - NIVEL 2 - TAREFA 2_|_  20.00_|_20051027_|_20051031_|_16:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_004_|__|_22_|_ \n2_|_2222222222_|_2           _|_EDT 2_|_  10.00_|_20051028_|_20051031_|_17:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_002_|__|_32_|_ \n1_|_2222222222_|_21          _|_EDT 2 - TAREFA 1_|_  10.00_|_20051028_|_20051031_|_17:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_003_|__|_15_|_ \n1_|_2222222222_|_22          _|_EDT 2 - TAREFA 2_|_  10.00_|_20051028_|_20051031_|_17:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_003_|__|_16_|_ \n2_|_2222222222_|_3           _|_EDT 3_|_  10.00_|_20050817_|_20050818_|_08:00_|_09:00_|_20051031_|_        _|_ 42.78%_|_0_|_002_|__|_34_|_ \n1_|_2222222222_|_31          _|_EDT 3 - TAREFA 1_|_  10.00_|_20050817_|_20050818_|_08:00_|_09:00_|_20051031_|_        _|_ 30.00%_|_0_|_003_|__|_17_|_ \n1_|_2222222222_|_32          _|_EDT 3 - TAREFA 2_|_  10.00_|_20050817_|_20050818_|_08:00_|_09:00_|_20051031_|_        _|_ 55.55%_|_0_|_003_|__|_18_|_ \n2_|_2222222222_|_4           _|_EDT 4_|_  10.00_|_20050817_|_20050818_|_08:00_|_09:00_|_20050818_|_        _|_ 60.00%_|_0_|_002_|__|_35_|_ \n1_|_2222222222_|_41          _|_EDT 4 - TAREFA 1_|_  10.00_|_20050817_|_20050818_|_08:00_|_09:00_|_20050818_|_        _|_ 20.00%_|_0_|_003_|__|_19_|_ \n1_|_2222222222_|_42          _|_EDT 4 - TAREFA 2_|_  10.00_|_20050817_|_20050818_|_08:00_|_09:00_|_20050818_|_20050818_|_100.00%_|_0_|_003_|__|_20_|_ \n1_|_2222222222_|_5           _|_TAREFA NA EDT PRINCIPAL_|_  50.00_|_20050818_|_20050825_|_08:00_|_14:00_|_20050824_|_20050824_|_100.00%_|_0_|_002_|__|_23_|_ \n2_|_2222222222_|_6           _|_EDT 5_|_  50.00_|_20050819_|_20050826_|_08:00_|_14:00_|_20050823_|_20050823_|_100.00%_|_0_|_002_|__|_37_|_ \n1_|_2222222222_|_61          _|_EDT 5 - TAREFA 1_|_  50.00_|_20050819_|_20050826_|_08:00_|_14:00_|_20050823_|_20050823_|_100.00%_|_0_|_003_|__|_24_|_ \n2_|_2222222222_|_7           _|_EDT 6_|_  20.00_|_20050822_|_20050824_|_08:00_|_10:00_|_20050823_|_        _|_ 20.00%_|_0_|_002_|__|_38_|_ \n1_|_2222222222_|_71          _|_EDT 6 - TAREFA 1_|_  20.00_|_20050822_|_20050824_|_08:00_|_10:00_|_20050823_|_        _|_ 20.00%_|_0_|_003_|__|_25_|_ \n1_|_2222222222_|_8           _|_TAREFA 2 NA EDT PRINCIPAL_|_  50.00_|_20050825_|_20050901_|_11:00_|_17:00_|_        _|_        _|_  0.00%_|_0_|_002_|__|_26_|_ \n2_|_2222222222_|_9           _|_EDT 7 - SEM TAREFA_|_   0.00_|_        _|_        _|_00:00_|_00:00_|_        _|_        _|_  0.00%_|_0_|_002_|__|_41_|_ \n1_|_2222222222_|_A           _|_TAREFA NA EDT PRINCIPAL PARA TESTE DE COR - ALT HTML_|_  20.00_|_20051027_|_20051031_|_16:00_|_18:00_|_        _|_        _|_  0.00%_|_0_|_002_|__|_29_|_ \n1_|_2222222222_|_B           _|_TAREFA B_|_  60.00_|_20051109_|_20051117_|_08:00_|_15:00_|_        _|_        _|_  0.00%_|_0_|_002_|__|_30_|_ \n1_|_2222222222_|_C           _|_TAREFA C_|_  60.00_|_20051102_|_20051110_|_08:00_|_15:00_|_20051101_|_        _|_ 33.33%_|_0_|_002_|__|_31_|_\n";
	Vector avalidos = strtovec("1,2,3,4",",", false);
	int i = 0;
	//Tira os caracteres da frente do String ate achar o primeiro valido
	for( i = 0 ; ( i < tsk.length() && avalidos.indexOf(tsk.substring(i,i+1))<0 ) ; i++) {
	}
	if (i>0){
	    tsk = tsk.substring(i);
	}
	atasks = strtovec( tsk  , "\n", false);
	
    }
    private void message(String cMsg) {/*System.out.println(cMsg);*/}
    private void message(int cMsg) {/*System.out.println(cMsg);*/}
    private void message(Object cMsg) {/*System.out.println(cMsg);*/}
    private void message(Float cMsg) {/*System.out.println(cMsg);*/}
    public void init(){
	
	DWHttpTalk	http ;
	String sURL = getDocumentBase().toString();
	if (sURL.indexOf('?') >=0)
	    sURL    +=	"&applet=1";
	else
	    sURL    +=	"?applet=1";
	message("sURL :"+sURL);
	int nLenStr = 0;
	try{
	    String sHeader = getParameter("HEADER");
	    message("Parametro :"+getParameter("LENGTH"));
	    nLenStr = Integer.parseInt(getParameter("LENGTH").toString());
	    aheader = strtovec( sHeader  , "#", false);
	} catch(Exception e) {
	    returnErr("Parametros obrigatorios nao recebidos.","Erro");
	    System.exit(0);
	}
	try{
	    message("nLenStr:"+String.valueOf(nLenStr));	    
	    message(nLenStr);	    
	    Vector avalidos = strtovec("1,2,3,4",",", false);
	    URL dwurl = new URL(sURL);
	    http =	new DWHttpTalk(dwurl);
	    String str ="";
	    int i = 0;
	    if (http.openRequest("GET", getParameter("SESSIONID"))) {
                for(int j=0; j<10000000;j++); //fazer o applet aguardar retorno do browse
		str =  http.read();
		message("HTTP READ - > primeira vez");
		message(str);
		message("LEN :"+String.valueOf(str.length()));
		int nLer	=  1;
		while (str.length()<(nLenStr+2) && i <= 100 )//Traz dois caracteres de controle como minimo
		{
		    for(int j=0; j<10000000;j++); //fazer o applet aguardar retorno do browse
		    str =    http.read();
		    if (nLer == 10)
		    {	dwurl = new URL(sURL);
			http =	new DWHttpTalk(dwurl);
			if (http.openRequest("GET", getParameter("SESSIONID")))
			    nLer   =	1;
		    }
		    message("HTTP READ - > "+ String.valueOf(i));
		    message(str);
		    nLer++;
		    i++;
		}		    
	    }else
	    {
		returnErr("Nao foi possivel obter retorno do Browser.","Erro");
		System.exit(0);
	    }
	    if (str.length()==0)
	    {	returnErr("Nao foi possivel obter retorno do Browser.","Erro");
		System.exit(0);
	    }
	    //Tira os caracteres da frente do String ate achar o primeiro valido
	    for( i = 0 ; ( i < str.length() && avalidos.indexOf(str.substring(i,i+1))<0 ) ; i++) {
	    }
	    if (i>0){
		str = str.substring(i);
	    }
	    atasks = strtovec( str  , "\n", false);
	    http.closeRequest();
	} catch(MalformedURLException e) {
	    returnErr(e.getMessage(),"Erro");
	    System.exit(0);
	} catch(Exception e1) {
	    returnErr(e1.getMessage(),"Erro");
	    System.exit(0);
	}
	if (atasks.size() >0) {
	    this.montaGantt();
	}else {
	    returnErr("Nao existem dados a serem exibidos.","Atencao");
	}
    }
    public void clickPerformed(java.awt.event.MouseEvent evt ){
	
	if (evt.MOUSE_CLICKED == MouseEvent.MOUSE_CLICKED) {//	pv.jfcx.JPVGanttNode node = (pv.jfcx.JPVGanttNode)graficoGantt.getTree().nodeAt(graficoGantt.unpack(graficoGantt.m_packedID, true));
	    JPVTree T = graficoGantt.getTree();
	    pv.jfcx.JPVGanttNode node = (pv.jfcx.JPVGanttNode)T.getSelectedNode();
	    if(node != null){
		int nodePos  = Integer.parseInt(node.getKey().toString());
		Vector atsktmp = strtovec( atasks.elementAt(nodePos).toString(),SEPARADOR,false) ;
//Inicio reposicionamento viewport
		if (evt.isShiftDown() && evt.getButton() == MouseEvent.BUTTON1 ) {	//Pegar as coordenadas atuais
		    
		    Point p = graficoGantt.getViewport().getViewPosition();
		    //Pegar a medida do gantt
		    float medida = (float)graficoGantt.getUnitsOfHeadersAt(pv.jfcx.JPVMSGantt.HEADER1);
		    // Verificar onde comeca o Gantt
		    //		    long nIniDate = graficoGantt.getStartValue();
		    GregorianCalendar dIniDate = (GregorianCalendar)graficoGantt.getStartObject();
		    long nIniDate	= (dIniDate.get(Calendar.YEAR)*YEAR + (dIniDate.get(Calendar.DAY_OF_YEAR))*DAY);
		    
		    // Somar ao comeco do gantt a coordenada atual para ter a data em que
		    //esta posicionado o ViewPort
		    float periodos=  (p.x/20) ;
		    nIniDate	+= (long)(periodos * medida);
		    
		    //Pegar a data de inicio da tarefa
		    String cTarDate = atsktmp.get(aheader.indexOf("ESTIMATEDINITIALDATE")).toString().trim();
		    String cTarHour = atsktmp.get(aheader.indexOf("ESTIMATEDINITIALHOUR")).toString().trim();
		    GregorianCalendar dTarDate = stringToCal(cTarDate, cTarHour );
		    dTarDate.set(Calendar.MINUTE,0);
		    dTarDate.set(Calendar.SECOND,0);
		    dTarDate.set(Calendar.MILLISECOND,0);
		    long nTarDate	= (dTarDate.get(Calendar.YEAR)*YEAR +(dTarDate.get(Calendar.DAY_OF_YEAR))*DAY+(dTarDate.get(Calendar.HOUR_OF_DAY)*HOUR));
		    nTarDate	-=  medida;
		    //Calcular a diferenca que devera ser desplazado o viewport
		    float dif = (float)((nTarDate-nIniDate)/medida);
		    
		    if (dif > (float)1 || dif*(-1) > (float)1)
			p.x += (int)(dif * 20.00);
		    
		    graficoGantt.getViewport().setViewPosition(p);
		    //graficoGantt.getViewport().setViewPosition(p);
		}
//fim reposicionamento viewport
		
		int tasktype = Integer.parseInt(atsktmp.get(aheader.indexOf("TASKTYPE")).toString().trim());
		//Se foi Duplo click abro os detalhes da tarefa.
		if (evt.getButton() ==  MouseEvent.BUTTON1 && evt.getClickCount()>1 ) {
		    String sURL = "";
		    if (tasktype==1){
			sURL = "javascript:window.open('"+this.getCodeBase()+"w_PWSP25FRAME.apw?cProjectCode="+atsktmp.get(aheader.indexOf("PROJECTCODE")).toString()+"&cTaskCode="+atsktmp.get(aheader.indexOf("TASKCODE")).toString()+"','Tarefa','width=600, height=400, scrollbars=no, menubar=no,addressbar=no');window.close();";
		    }else{ if (tasktype==2)
			sURL = "javascript:window.open('"+this.getCodeBase()+"w_PWSP024FRAME.apw?cProjectCode="+atsktmp.get(aheader.indexOf("PROJECTCODE")).toString()+"&cWbsCode="+atsktmp.get(aheader.indexOf("TASKCODE")).toString()+"','EDT','width=600, height=400, scrollbars=no, menubar=no,addressbar=no');window.close();";
		    }
		    if (sURL.compareTo("")!=0 ) {
			try{
			    URL dwurl = new URL(sURL);
			    this.getAppletContext().showDocument(dwurl,"_blank");
			} catch(MalformedURLException e) {
			    returnErr(e.getMessage(),"Erro");
			}
		    }
		}
		atuRodape(tasktype, atsktmp);
	    }
	    
	}
    }
    private String stod(String data) {
	String cRet = "";
	String cAno    =	data.substring(0, 4);
	String cMes    =	data.substring(4, 6);
	String cDia    =	data.substring(6, 8);
	cRet    =	cDia+"/"+cMes+"/"+cAno;
	return cRet;
    }
    public void atuRodape(int tasktype,Vector atsktmp) {
	String cDado = "";
	switch (tasktype){
	    case 1: cDado   = "Tarefa " ;	break;
	    case 2: cDado   = "EDT "    ;   break;
	    case 3: cDado   =  "Recurso ";	break;
	    case 4: cDado   = "Equipe " ;	break;
	}
	
	cDado  += atsktmp.get(aheader.indexOf("TASKCODE")).toString().trim();
	cDado += " : "+atsktmp.get(aheader.indexOf("TASKDESCRIPTION")).toString().trim();
	taskInfo.setText(cDado);
	
	cDado	= stod(atsktmp.get(aheader.indexOf("ESTIMATEDINITIALDATE")).toString().trim());
	cDado	+="-"+atsktmp.get(aheader.indexOf("ESTIMATEDINITIALHOUR")).toString().trim();
	cDado	+="->"+stod(atsktmp.get(aheader.indexOf("ESTIMATEDFINALDATE")).toString().trim());
	cDado	+="-"+atsktmp.get(aheader.indexOf("ESTIMATEDFINALHOUR")).toString().trim();
	cDado	+=" / POC "+atsktmp.get(aheader.indexOf("POC")).toString().trim();
	
	taskInfoP.setText(cDado);
	
	cDado	= atsktmp.get(aheader.indexOf("RESOURCES")).toString().trim();
	
	taskInfoRec.setText(cDado);
	taskInfo.setToolTipText("Faça duplo clique na barra da tarefa para ver detalhes");
	taskInfoP.setToolTipText("Faça duplo clique na barra da tarefa para ver detalhes");
	taskInfoRec.setToolTipText("Faça duplo clique na barra da tarefa para ver detalhes");
	
    }
    public void setas(java.awt.event.KeyEvent evt ){
	JPVTree T = graficoGantt.getTree();
	pv.jfcx.JPVGanttNode node = (pv.jfcx.JPVGanttNode)T.getSelectedNode();
	if(node != null){
	    int nodePos  = Integer.parseInt(node.getKey().toString());
	    Vector atsktmp = strtovec( atasks.elementAt(nodePos).toString(),SEPARADOR,false) ;
	    atuRodape(Integer.parseInt(atsktmp.get(aheader.indexOf("TASKTYPE")).toString().trim()),atsktmp);
	}
    }
    private void initComponents() {
	toppainel = new javax.swing.JPanel();
	zoomToolbar = new javax.swing.JToolBar();
	zoomInBtn = new javax.swing.JButton();
	zoomoutBtn = new javax.swing.JButton();
	scrollToolbar = new javax.swing.JToolBar();
	leftScrollBtn = new javax.swing.JButton();
	comboPainel = new javax.swing.JPanel();
	scrollSizeCombo = new javax.swing.JComboBox();
	rightScrollBtn = new javax.swing.JButton();
	printBtn = new javax.swing.JButton();
	
	
	toppainel.setLayout(new javax.swing.BoxLayout(toppainel, javax.swing.BoxLayout.X_AXIS));
	
	zoomInBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/gantt/images/pmszoomout.gif")));
	zoomInBtn.setToolTipText("Zoom -");
	zoomInBtn.addMouseListener(new java.awt.event.MouseAdapter() {
	    public void mouseClicked(java.awt.event.MouseEvent evt) {
		zoomInBtnMouseClicked(evt);
	    }
	});
	zoomToolbar.setName("Zoom");
	zoomToolbar.add(zoomInBtn);
	
	zoomoutBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/gantt/images/pmszoomin.gif")));
	zoomoutBtn.addMouseListener(new java.awt.event.MouseAdapter() {
	    public void mouseClicked(java.awt.event.MouseEvent evt) {
		zoomoutBtnMouseClicked(evt);
	    }
	});
	
	zoomToolbar.add(zoomoutBtn);
	
	toppainel.add(zoomToolbar);
	
	leftScrollBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/gantt/images/left.gif")));
	leftScrollBtn.setToolTipText("Desplazar para a esquerda");
	leftScrollBtn.addActionListener(new java.awt.event.ActionListener() {
	    public void actionPerformed(java.awt.event.ActionEvent evt) {
		leftScrollBtnActionPerformed(evt);
	    }
	});
	
	scrollToolbar.add(leftScrollBtn);
	scrollToolbar.setMaximumSize(new java.awt.Dimension(180, 41));
	scrollToolbar.setMinimumSize(new java.awt.Dimension(180, 41));
	scrollToolbar.setName("Desplazamento");
	scrollSizeCombo.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "Opcao 1", "Opcao 2", "Opcao 3", "Opcao 4" }));
	scrollSizeCombo.setBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.RAISED));
	scrollSizeCombo.setNextFocusableComponent(rightScrollBtn);
	scrollSizeCombo.addActionListener(new java.awt.event.ActionListener() {
	    public void actionPerformed(java.awt.event.ActionEvent evt) {
		scrollSizeComboActionPerformed(evt);
	    }
	});
	
	comboPainel.add(scrollSizeCombo);
	
	scrollToolbar.add(comboPainel);
	
//        rightScrollBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/javaapplication5/images/right.gif")));
	rightScrollBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/gantt/images/right.gif")));
	rightScrollBtn.setToolTipText("Desplazar para a direita");
	rightScrollBtn.addActionListener(new java.awt.event.ActionListener() {
	    public void actionPerformed(java.awt.event.ActionEvent evt) {
		rightScrollBtnActionPerformed(evt);
	    }
	});
	
	scrollToolbar.add(rightScrollBtn);
	
	toppainel.add(scrollToolbar);
	
	printBtn.setText("Imprimir");
	printBtn.addActionListener(new java.awt.event.ActionListener() {
	    public void actionPerformed(java.awt.event.ActionEvent evt) {
		printBtnActionPerformed(evt);
	    }
	});
	
	toppainel.add(printBtn);
	
	
	//       getContentPane().add(toppainel);
	
    }
    // </editor-fold>
    
    private void zoomoutBtnMouseClicked(java.awt.event.MouseEvent evt) {
	updateZoom(true);
    }
    
    private void zoomInBtnMouseClicked(java.awt.event.MouseEvent evt) {
// TODO add your handling code here:
	updateZoom(false);
    }
    
    private void rightScrollBtnActionPerformed(java.awt.event.ActionEvent evt) {
	Point p = graficoGantt.getViewport().getViewPosition();
	int posUnit =	scrollSizeCombo.getSelectedIndex()+regua.posbase;
	p.x +=	20 * (regua.units[posUnit]/ regua.units[0] );
	if (p.x <= graficoGantt.getViewport().getExtentSize().width)
	    p.x = graficoGantt.getViewport().getExtentSize().width - 20;
	graficoGantt.getViewport().setViewPosition(p);
    }
    private void scrollSizeComboActionPerformed(java.awt.event.ActionEvent evt) {
	//zoomOpt = regua.posbase+((JComboBox)evt.getSource()).getSelectedIndex();
    }
    
    private void leftScrollBtnActionPerformed(java.awt.event.ActionEvent evt) {
	Point p = graficoGantt.getViewport().getViewPosition();
	int posUnit =	scrollSizeCombo.getSelectedIndex()+regua.posbase;
	p.x -=	20 * (regua.units[posUnit]/ regua.units[0] );
	if (p.x < 0)
	    p.x = 0;
	graficoGantt.getViewport().setViewPosition(p);
    }
    private void printBtnActionPerformed(java.awt.event.ActionEvent evt) {
	String sURL = "javascript:print();";
	try{
	    URL dwurl = new URL(sURL);
	    this.getAppletContext().showDocument(dwurl);
	} catch(MalformedURLException e){
	    returnErr(e.getMessage(),"Erro");
	}
    }
    /*
   public void processMouseEvent(MouseEvent e) {
    String type = null;
    switch (e.getID()) {
    case MouseEvent.MOUSE_PRESSED:
      type = "MOUSE_PRESSED";
      break;
    case MouseEvent.MOUSE_RELEASED:
      type = "MOUSE_RELEASED";
      break;
    case MouseEvent.MOUSE_CLICKED:
      type = "MOUSE_CLICKED";
      break;
    case MouseEvent.MOUSE_ENTERED:
      type = "MOUSE_ENTERED";
      break;
    case MouseEvent.MOUSE_EXITED:
      type = "MOUSE_EXITED";
      break;
    }
    message(type);
   }*/
    // Variables declaration - do not modify
    private javax.swing.JPanel comboPainel;
    private javax.swing.JButton leftScrollBtn;
    private javax.swing.JButton rightScrollBtn;
    private javax.swing.JComboBox scrollSizeCombo;
    private javax.swing.JToolBar scrollToolbar;
    private javax.swing.JPanel toppainel;
    private javax.swing.JButton zoomInBtn;
    private javax.swing.JToolBar zoomToolbar;
    private javax.swing.JButton zoomoutBtn;
    private javax.swing.JButton printBtn;
    // End of variables declaration
    
    //-------------------------
}



