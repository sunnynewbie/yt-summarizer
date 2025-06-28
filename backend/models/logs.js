import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class logs extends Model {
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
      allowNull: true,
      references: {
        model: 'media',
        key: 'id'
      }
    },
    level: {
      type: DataTypes.STRING(10),
      allowNull: true,
      defaultValue: "info"
    },
    message: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    meta: {
      type: DataTypes.JSONB,
      allowNull: true
    },
    timestamp: {
      type: DataTypes.DATE,
      allowNull: true,
      defaultValue: Sequelize.Sequelize.fn('now')
    }
  }, {
    sequelize,
    tableName: 'logs',
    schema: 'public',
    timestamps: false,
    indexes: [
      {
        name: "logs_pkey",
        unique: true,
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
  }
}
