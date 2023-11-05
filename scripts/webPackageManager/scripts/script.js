import packages from "../data/packages.json" assert { type: "json" };

const distros = document.querySelector("#distros");
const packagesTable = document.querySelector(".packages-table");
const addPackageBtn = document.querySelector("#add-package");
const addPackageForm = document.querySelector("form");
const saveToFileBtn = document.querySelector("#save-packages");
const filterPackagesLink = document.querySelector("#filter-packages");

let distroValue = distros.value;
filterPackagesLink.href = `./pages/packages/index.html?distro=${distroValue}`;

packagesTable.innerHTML = `
  <tr>
    <th>Name</th>
    <th>Category</th>
  </tr>
`;

for (const packageItem of packages[distroValue]) {
  packagesTable.innerHTML += `
    <tr>
      <td>${packageItem.name}</td>
      <td>${packageItem.category}</td>
    </tr>
  `;
}

// functions
function renderPackages() {
  packagesTable.innerHTML = `
    <tr>
      <th>Name</th>
      <th>Category</th>
    </tr>
  `;

  for (const packageItem of packages[distroValue]) {
    packagesTable.innerHTML += `
      <tr>
        <td>${packageItem.name}</td>
        <td>${packageItem.category}</td>
      </tr>
    `;
  }
}

function savePackages() {
  const data = JSON.stringify(packages);
  const blob = new Blob([data], { type: "application/json" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = "packages.json";
  a.click();
}

// event listeners
distros.addEventListener("change", (e) => {
  distroValue = e.target.value;
  renderPackages();
});

addPackageBtn.addEventListener("click", (e) => {
  e.preventDefault();
  const name = document.querySelector("#package-name").value;
  const categoryList = document.querySelector("#package-category").value; // comma separated
  const category = categoryList.split(",").map((item) => item.trim());

  packages[distroValue].push({ name, category });
  renderPackages();
  addPackageForm.reset();
});

saveToFileBtn.addEventListener("click", (e) => {
  e.preventDefault();
  savePackages();
});
