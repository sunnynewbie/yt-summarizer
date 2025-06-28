import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class transcripts extends Model {
  static init(sequelize, DataTypes) {
  return super.init({
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    media_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'media',
        key: 'id'
      }
    },
    language: {
      type: DataTypes.STRING(10),
      allowNull: true,
      defaultValue: "en"
    },
    format: {
      type: DataTypes.STRING(20),
      allowNull: true,
      defaultValue: "text"
    },
    content: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    confidence: {
      type: DataTypes.DECIMAL,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'transcripts',
    schema: 'public',
    timestamps: true,
    indexes: [
      {
        name: "transcripts_pkey",
        unique: true,
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
  }
}
