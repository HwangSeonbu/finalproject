package kr.or.ddit.vo;

import java.io.Serializable;
import java.sql.SQLData;
import java.sql.SQLException;
import java.sql.SQLInput;
import java.sql.SQLOutput;

import lombok.Data;
import lombok.EqualsAndHashCode;
@Data
@EqualsAndHashCode(of="evaId")
public class EvaStandardVO implements Serializable, SQLData {
	private String evaId;
	private String evaStd;
	private Integer evaScore;
	private Integer lechwkNo=0;
	@Override
	public String getSQLTypeName() throws SQLException {
		// TODO Auto-generated method stub
		return "EVASTD";
	}
	@Override
	public void readSQL(SQLInput stream, String typeName) throws SQLException {
		// TODO Auto-generated method stub
		this.evaId=stream.readString();
		this.evaStd=stream.readString();
		this.evaScore=stream.readInt();
		this.lechwkNo=stream.readInt();
	}
	@Override
	public void writeSQL(SQLOutput stream) throws SQLException {
		stream.writeString(evaId);
		stream.writeString(evaStd);
		stream.writeInt(evaScore);
		stream.writeInt(lechwkNo);
		
	}
	
}
