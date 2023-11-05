import packages from "../../data/packages.json" assert { type: "json" };

const categoriesSelector = document.querySelector("#categories");
const urlParams = new URLSearchParams(window.location.search);
const distro = urlParams.get("distro");
const packagesTable = document.querySelector(".packages-table");

const categories = packages[distro].reduce((acc, packageItem) => {
  packageItem.category.forEach((category) => {
    if (!acc.includes(category)) {
      acc.push(category);
    }
  });
  return acc;
}, []);

let selectedCategory = "";
packagesTable.innerHTML = `
  <tr>
    <th>Name</th>
    <th>Category</th>
  </tr>
`;

addCategoryOptionsToSelector();
renderPackagesTable();

// functioons
function addCategoryOptionsToSelector() {
  categories.forEach((category) => {
    categoriesSelector.innerHTML += `<option value="${category}">${category}</option>`;
  });
}

function renderPackagesTable() {
  packagesTable.innerHTML = `
    <tr>
      <th>Name</th>
      <th>Category</th>
    </tr>
  `;
  for(const packageItem of packages[distro]){
    if(packageItem.category.includes(selectedCategory)){
      packagesTable.innerHTML += `
        <tr>
          <td>${packageItem.name}</td>
          <td>${packageItem.category}</td>
        </tr>
      `;
    }
  }
}

// events
categoriesSelector.addEventListener("change", (e) => {
  selectedCategory = e.target.value;
  renderPackagesTable();
});

