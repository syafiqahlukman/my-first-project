// models/Item.js
const mongoose = require('mongoose');

const itemSchema = new mongoose.Schema({
  name: String,
  price: Number,
  quantity: Number, // Add the quantity field
});

const Item = mongoose.model('Item', itemSchema);

module.exports = Item;