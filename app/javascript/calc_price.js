window.addEventListener('load', () => {
  const TAX_RATE = 0.1;

  const item_price = document.getElementById('item-price');
  const add_tax_price = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  item_price.addEventListener('input', () => {
    const item_price_value = item_price.value;
    const add_tax_price_value = Math.floor(item_price_value * TAX_RATE); 
    add_tax_price.textContent =  add_tax_price_value;
    profit.textContent = item_price_value - add_tax_price_value;
  });
});
