package pv.jfcx;
import javax.swing.*;
import javax.swing.plaf.*;
import javax.swing.event.*;
import javax.swing.tree.*;
import javax.swing.border.*;
import java.awt.*;
import java.awt.event.*;
import java.beans.*;
import java.io.*;
import java.util.*;
import java.text.*;
import pv.util.*;
/**
Component that on the left side displays tree, and on the right side
displays data for every node of the tree as array of rectangles.
<br>Every rectangle may represent any kind of data. Here bounds of rectangles
represent start and end dates (appointments) of a node.<br>
To define data, an application has several options:
	<OL>
	<LI>Implement the PVModel interface and set it as the model for the JPVMSGAntt.
	<LI>Override the PVNode and implement PVModel interface.
	<LI>Use the JPVGanttNode which implements the PVModel interface.
	<LI>Use mixed models: both for nodes and JPVMSGAntt. In this case
	model of a node has priority. If appearance or data provided by a node
	is missing (null), then a value from the main model is used automatically.
	It means, that data and appearance can be separated and supplied by different
	models.
	</OL>
@see #setModel
@version 6.01 06/11/02
@author Viktor Snezhko
*/
public class JPVMSGantt extends JPVGantt
{//	public GregorianCalendar baseDate = new GregorianCalendar();
	static final long HOUR=1000 * 60 * 60 ;
	static final long DAY =HOUR * 24;
	static final long MONTH = DAY * 30;
	static final long YEAR = MONTH * 12;

        public JPVMSGantt(){super();}
	/**
	Constructor.
	@param root node that contains structured data.
	@see #createTree
	*/
	public JPVMSGantt(PVNode root)
	{
		super(root);
	}
	public JComponent getPainter()
	{
		if(m_painter == null)
		{
			m_painter = new JComponent()
			{
				protected void paintComponent(Graphics g)
				{
					try
					{
					//-----------
					// bounds of area to paint
					Rectangle r = null;
					if(!getPaintAll()) { r = this.getVisibleRect(); if(r.width < 10) r = null; }
					if(r == null) r = new Rectangle(this.getSize());
					//-----------
					// background image
					img(g, r, m_imagePainter, this, false);
					int iSel, iH = m_iCols * m_iColW, ii = r.x;
					//-----------
					// if area smaller than full, then increase it by 10
					// horizontal interseptions
					if(ii > 10) ii = 10;
					r.x -= ii; r.width += ii;
					ii = iH - (r.x + r.width);
					if(ii > 0) { r.width += ((ii > 10) ? 10 : ii); }
					//-----------
					// vertical interseptions
					if((ii = r.y) > 5) ii = 5;
					r.y -= ii; r.height += ii;
					//-----------
					// width of area for bars (it can be less than width of component)
					r.width += r.x; r.height += r.y;
					if(r.width > iH) r.width = iH;
					//-----------
					//BaseLine
					GregorianCalendar dBaseDate = new GregorianCalendar();
					GregorianCalendar dIniDate = (GregorianCalendar)getStartObject();
					dBaseDate.set(Calendar.MINUTE,0);
			    	        dBaseDate.set(Calendar.SECOND,0);
					dBaseDate.set(Calendar.MILLISECOND,0);
					long nBaseDate	= (dBaseDate.get(Calendar.YEAR)*YEAR +(dBaseDate.get(Calendar.DAY_OF_YEAR))*DAY+(dBaseDate.get(Calendar.HOUR_OF_DAY)*HOUR));
					long nIniDate	= (dIniDate.get(Calendar.YEAR)*YEAR + (dIniDate.get(Calendar.DAY_OF_YEAR))*DAY);
					float medida = (float)getUnitsOfHeadersAt(pv.jfcx.JPVMSGantt.HEADER1);
					float dif = (float)((nBaseDate-nIniDate)/medida);
					
					int nPos = (int)(dif * 20.00);
					Color color = g.getColor();
					g.setColor(new Color( 0xff0000 ));
					g.fillRect(nPos, r.y, 2, r.height);
					g.setColor(color);

					//-----------
					// grid
					if(m_cL != null)
					{
						g.setColor(m_cL);
						if((iH = getHorizontalGrid() * m_h) != 0)
						{
							ii = (r.y / iH) * iH;
							while((ii += iH) <= r.height) g.drawLine(r.x, ii - 1, r.width, ii - 1);
						}

						if((iH = getVerticalGrid() * m_iColW) != 0)
						{
							ii = (r.x / iH) * iH;
							while((ii += iH) <= r.width) 
							{   //System.out.println(ii);
							    g.drawLine(ii - 1, r.y, ii - 1, r.height);
							}
							
						}
					}
					//-----------
					// i - index of top data (vertical intersection)
					int i = r.y / m_h;
					//-----------
					// iY - top of bar
					int iY = ((iH = getSpacing()) + 1) / 2 + i-- * m_h;
					//-----------
					// iH - height of bar
					iH = m_h - iH;
					Object o, v = null;
					PVBar bar;
					while(++i < m_data.size())
					{
						ii = 0;
						Vector data = null, row = row(i);
						//-----------
						// read bounds data
						if(row != null) if((data = (Vector)row.elementAt(0)) != null)
						{
							ii = data.size();
							//-----------
							// read appearance data
							v = row.elementAt(1);
						}
						//-----------
						// draw bars
						while(ii-- > 0)
						{
							//-----------
							// calculate location of bar
							Point p = (Point)data.elementAt(ii);
							//-----------
							// check horizontal intersection
							if(p.x + p.y <= r.x || p.x >= r.width) continue;
							//-----------
							// set bounds and left/right edges
							Rectangle rb = new Rectangle(p.x, iY, p.y, iH);
							if(rb.x + rb.width > r.width) rb.width = r.width - rb.x;
							if(rb.x < r.x) { rb.width -= (r.x - rb.x); rb.x = r.x; }
							//-----------
							// construct bar for appearance
							if((o = v) instanceof Vector)
								o = (((Vector)v).size() > ii) ? ((Vector)v).elementAt(ii) : null;
							if(o instanceof PVBar) bar = (PVBar)o;
							else
							{
								bar = (PVBar)m_bar.clone();
								if(o instanceof Color) bar.m_back = (Color)o;
								if(o instanceof Image) bar.m_image = (Image)o;
							}
							bar.m_this = bar;
							if((iSel = isSelected(m_packedID = pack(i, ii))) > 0)
							{
								//-----------
								// configure focus/selection using m_this priority
								bar.m_this = (iSel == 2) ? m_focusBar : m_selectedBar;
								bar.m_this.m_this = bar;
								if((iSel & getLargeSelectedBar()) != 0) rb.grow(1, 1);
							}
							bar.paint(g, rb, this);
						}
						//-----------
						// check vertical intersection
						if((iY += m_h) >= r.height) break;
					}

					}catch(Exception e){}
				}
				public Dimension getPreferredSize()
				{ return new Dimension(m_iCols * m_iColW, m_data.size() * m_h); }
			};
			m_painter.setOpaque(true);
			m_painter.setBackground(Color.white);
			m_painter.addMouseListener(this);
		}
		return m_painter;
	}

}