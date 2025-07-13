import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class userSocialAccounts extends Model {
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
      allowNull: true,
      references: {
        model: 'users',
        key: 'id'
      }
    },
    provider: {
      type: DataTypes.TEXT,
      allowNull: true,
      unique: "user_social_accounts_provider_provider_user_id_key"
    },
    provider_user_id: {
      type: DataTypes.TEXT,
      allowNull: false,
      unique: "user_social_accounts_provider_provider_user_id_key"
    }
  }, {
    sequelize,
    tableName: 'user_social_accounts',
    schema: 'public',
    timestamps: false,
    indexes: [
      {
        name: "user_social_accounts_pkey",
        unique: true,
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "user_social_accounts_provider_provider_user_id_key",
        unique: true,
        fields: [
          { name: "provider" },
          { name: "provider_user_id" },
        ]
      },
    ]
  });
  }
}
