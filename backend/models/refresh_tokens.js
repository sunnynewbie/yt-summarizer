import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class refreshTokens extends Model {
  static init(sequelize, DataTypes) {
  return super.init({
    id: {
      type: DataTypes.UUID,
      allowNull: false,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.UUID,
      allowNull: false,
      references: {
        model: 'users',
        key: 'id'
      }
    },
    token: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    expires_at: {
      type: DataTypes.DATE,
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'refresh_tokens',
    schema: 'public',
    timestamps: false,
    indexes: [
      {
        name: "idx_refresh_tokens_user_id",
        fields: [
          { name: "user_id" },
        ]
      },
      {
        name: "refresh_tokens_token_key",
        unique: true,
        fields: [
          { name: "token" },
        ]
      },
      {
        name: "refresh_tokens_pkey",
        unique: true,
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
  }
}
