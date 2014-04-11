module.exports = function(sequilize, DataTypes) {
    return sequilize.define("sparkUsers",
        {
            username: DataTypes.STRING,
            password: DataTypes.STRING
        });
}